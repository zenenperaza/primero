# frozen_string_literal: true

# Start from Primero's standard CP configuration, then add the Venezuela
# locations and the FTR-oriented users used by this local deployment.
unless ENV['PRIMERO_VENEZUELA_REPLACE_LOCATIONS'] == 'true'
  raise <<~MESSAGE
    Replacing locations is destructive. Set
    PRIMERO_VENEZUELA_REPLACE_LOCATIONS=true after creating a database backup.
  MESSAGE
end

configured_locales = I18n.available_locales
configured_default_locale = I18n.default_locale
I18n.available_locales = [:en]
I18n.default_locale = :en
load Rails.root.join('db', 'configuration', 'load_configuration.rb').to_s
I18n.available_locales = configured_locales
I18n.default_locale = configured_default_locale

load File.join(__dir__, 'translations_es.rb')
# The custom LRF Tracing Request forms are backed up in
# ftr_solicitudes_localizacion.rb and can be loaded later when the workflow is
# ready to be installed again.

puts 'Configuring English base language and Spanish translations'
SystemSettings.current.update!(
  base_language: 'en',
  default_locale: 'es',
  locales: %w[en es]
)

puts 'Enabling Tracing Request media uploads'
media_section = FormSection.find_by!(unique_id: 'tracing_request_photos_and_audio')
media_fields = media_section.fields.map do |field|
  if %w[photos recorded_audio].include?(field['name'])
    field['editable'] = true
    field['disabled'] = false
  end
  field
end
media_section.update!(editable: true, fields: media_fields)

puts 'Assigning missing CP form groups'
FormSection.where(unique_id: 'cp_other_reportable_fields').update_all(form_group_id: 'other_reportable_fields')
incident_form_group_lookup = Lookup.find_by!(unique_id: 'lookup-form-group-cp-incident')
incident_form_group_values = incident_form_group_lookup.lookup_values_i18n || []
other_reportable_fields_group = incident_form_group_values.find { |value| value['id'] == 'other_reportable_fields' }

if other_reportable_fields_group
  other_reportable_fields_group['display_text'] ||= {}
else
  other_reportable_fields_group = { 'id' => 'other_reportable_fields', 'display_text' => {} }
  incident_form_group_values << other_reportable_fields_group
end

other_reportable_fields_group['display_text']['en'] = 'Other Reportable Fields'
other_reportable_fields_group['display_text']['es'] = 'Otros campos de reporte'
incident_form_group_lookup.update!(lookup_values_i18n: incident_form_group_values)

puts 'Loading Venezuela states and municipalities'
system_settings = SystemSettings.current
system_settings.update!(
  reporting_location_config: {
    field_key: 'owned_by_location',
    admin_level: 1,
    admin_level_map: { '1' => ['state'], '2' => ['municipality'] }
  }
)

Location.destroy_all
locations_file = File.join(__dir__, 'locations_venezuela_hxl.csv')
locations_importer = Importers::CsvHxlLocationImporter.new
File.open(locations_file, 'r:bom|utf-8') { |file| locations_importer.import(file) }

unless locations_importer.errors.empty?
  raise "Venezuela location import failed: #{locations_importer.errors.join('; ')}"
end

puts 'Configuring ASONACOP LRF agency, territorial groups, roles and users'
cp_module = PrimeroModule.cp
asonacop = Agency.create_or_update!(
  unique_id: 'LRF',
  agency_code: 'LRF',
  name_en: 'ASONACOP',
  name_es: 'ASONACOP',
  description_en: 'Localization and Family Reunification Program',
  description_es: 'Programa de Localización y Reunificación Familiar',
  disabled: false,
  exclude_agency_from_lookups: false
)
ftr_forms = FormSection.where(parent_form: 'tracing_request')
ftr_group = UserGroup.create_or_update!(
  unique_id: 'usergroup-primero-ftr',
  name: 'LRF Nacional',
  description: 'Solicitudes de Localización - ASONACOP',
  agency_unique_ids: [asonacop.unique_id]
)
lrf_territorial_location_codes = %w[VE01 VE02]
lrf_territorial_group_ids = lrf_territorial_location_codes.map { |code| "usergroup-lrf-state-#{code.downcase}" }
UserGroup.where("unique_id LIKE 'usergroup-lrf-state-%'")
         .where.not(unique_id: lrf_territorial_group_ids)
         .find_each do |group|
  group.users.clear
  group.agencies.clear
  group.destroy!
end

territorial_groups = Location.where(admin_level: 1, location_code: lrf_territorial_location_codes).order(:placename_es).map do |state|
  state_name = state.placename_es.presence || state.placename_en
  UserGroup.create_or_update!(
    unique_id: "usergroup-lrf-state-#{state.location_code.downcase}",
    name: "LRF - #{state_name}",
    description: "Equipo territorial LRF de #{state_name}",
    agency_unique_ids: [asonacop.unique_id]
  )
end

lrf_tracing_manage = [
  Permission.new(
    resource: Permission::TRACING_REQUEST,
    actions: [Permission::MANAGE, Permission::VIEW_PHOTO, Permission::VIEW_AUDIO]
  ),
  Permission.new(resource: Permission::POTENTIAL_MATCH, actions: [Permission::MANAGE]),
  Permission.new(resource: Permission::CASE, actions: [Permission::READ, Permission::FIND_TRACING_MATCH]),
  Permission.new(
    resource: Permission::DASHBOARD,
    actions: [
      Permission::DASH_MATCHING_RESULTS,
      Permission::DASH_GROUP_OVERVIEW,
      Permission::DASH_REPORTING_LOCATION,
      Permission::DASH_FLAGS
    ]
  )
]
lrf_tracing_supervise = [
  Permission.new(
    resource: Permission::TRACING_REQUEST,
    actions: [
      Permission::READ,
      Permission::EXPORT_LIST_VIEW,
      Permission::EXPORT_CSV,
      Permission::EXPORT_EXCEL,
      Permission::EXPORT_PDF,
      Permission::CHANGE_LOG,
      Permission::ACCESS_LOG,
      Permission::VIEW_PHOTO,
      Permission::VIEW_AUDIO
    ]
  ),
  Permission.new(
    resource: Permission::POTENTIAL_MATCH,
    actions: [Permission::READ, Permission::VIEW_PHOTO, Permission::VIEW_AUDIO]
  )
]
lrf_case_approval_actions = [
  Permission::READ,
  Permission::FIND_TRACING_MATCH,
  Permission::APPROVE_ASSESSMENT,
  Permission::APPROVE_CASE_PLAN,
  Permission::APPROVE_CLOSURE,
  Permission::APPROVE_ACTION_PLAN,
  Permission::CHANGE_LOG
]

lrf_administrator = Role.create_or_update!(
  unique_id: 'role-lrf-administrator',
  name: 'Administrador LRF',
  description: 'Administra a nivel nacional usuarios, roles, grupos y solicitudes LRF',
  permissions: lrf_tracing_manage + [
    Permission.new(resource: Permission::USER, actions: [Permission::MANAGE]),
    Permission.new(resource: Permission::USER_GROUP, actions: [Permission::MANAGE]),
    Permission.new(resource: Permission::ROLE, actions: [Permission::READ, Permission::CREATE, Permission::WRITE, Permission::ASSIGN, Permission::COPY]),
    Permission.new(resource: Permission::AGENCY, actions: [Permission::READ, Permission::WRITE]),
    Permission.new(resource: Permission::REPORT, actions: [Permission::MANAGE]),
    Permission.new(resource: Permission::AUDIT_LOG, actions: [Permission::READ])
  ],
  group_permission: Permission::ALL,
  is_manager: true,
  modules: [cp_module],
  form_sections: ftr_forms
)

lrf_monitor = Role.create_or_update!(
  unique_id: 'role-lrf-monitor',
  name: 'Monitor LRF',
  description: 'Monitorea y gestiona todas las solicitudes LRF a nivel nacional',
  permissions: lrf_tracing_manage + [
    Permission.new(resource: Permission::REPORT, actions: [Permission::READ])
  ],
  group_permission: Permission::ALL,
  modules: [cp_module],
  form_sections: ftr_forms
)

lrf_regional_coordinator = Role.create_or_update!(
  unique_id: 'role-ftr-manager',
  name: 'Coordinador Regional LRF',
  description: 'Gestiona las solicitudes LRF de los grupos territoriales asignados',
  permissions: lrf_tracing_manage + [
    Permission.new(resource: Permission::USER, actions: [Permission::READ]),
    Permission.new(resource: Permission::USER_GROUP, actions: [Permission::READ]),
    Permission.new(resource: Permission::REPORT, actions: [Permission::READ])
  ],
  group_permission: Permission::GROUP,
  is_manager: true,
  modules: [cp_module],
  form_sections: ftr_forms
)

lrf_field_coordinator = Role.create_or_update!(
  unique_id: 'role-ftr-worker',
  name: 'Coordinador Terreno LRF',
  description: 'Registra y gestiona las solicitudes LRF del estado o grupo territorial asignado',
  permissions: lrf_tracing_manage,
  group_permission: Permission::GROUP,
  modules: [cp_module],
  form_sections: ftr_forms
)

lrf_manager = Role.create_or_update!(
  unique_id: 'role-lrf-manager',
  name: 'Gerente LRF',
  description: 'Supervisa nacionalmente y aprueba casos vinculados al flujo LRF',
  permissions: lrf_tracing_supervise + [
    Permission.new(resource: Permission::CASE, actions: lrf_case_approval_actions),
    Permission.new(resource: Permission::REPORT, actions: [Permission::READ, Permission::GROUP_READ]),
    Permission.new(
      resource: Permission::DASHBOARD,
      actions: [
        Permission::DASH_APPROVALS_ASSESSMENT,
        Permission::DASH_APPROVALS_CASE_PLAN,
        Permission::DASH_APPROVALS_CLOSURE,
        Permission::DASH_APPROVALS_ACTION_PLAN,
        Permission::DASH_NATIONAL_ADMIN_SUMMARY
      ]
    )
  ],
  group_permission: Permission::ALL,
  is_manager: true,
  modules: [cp_module],
  form_sections: ftr_forms
)

[
  ['primero_ftr', 'Coordinador Terreno LRF', lrf_field_coordinator, 'PRIMERO_FTR_WORKER'],
  ['primero_mgr_ftr', 'Gerente LRF', lrf_manager, 'PRIMERO_FTR_MANAGER']
].each do |user_name, full_name, role, env_prefix|
  user = User.find_or_initialize_by(user_name:)
  if user.new_record?
    password = ENV.fetch("#{env_prefix}_PASSWORD")
    user.assign_attributes(
      'password' => password,
      'password_confirmation' => password,
      'email' => ENV.fetch("#{env_prefix}_EMAIL")
    )
  end

  user.assign_attributes(
    'full_name' => full_name,
    'disabled' => false,
    'agency_id' => asonacop.id,
    'role_id' => role.id,
    'user_groups' => [ftr_group],
    'locale' => 'es'
  )
  user.save!
end

# Preserve locally created LRF users while moving the operational agency from
# Primero's standard UNICEF seed to ASONACOP.
User.joins(:role).where(
  roles: { unique_id: %w[role-lrf-administrator role-lrf-monitor role-ftr-manager role-ftr-worker role-lrf-manager] }
).find_each do |user|
  user.update!(agency_id: asonacop.id)
end

User.where(user_name: %w[admin primero]).update_all(locale: 'es')
GenerateLocationFilesJob.perform_now

puts "Loaded #{Location.count} Venezuela locations and configured #{ftr_group.name} with #{territorial_groups.count} territorial groups"
