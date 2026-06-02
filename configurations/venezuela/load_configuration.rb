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
load File.join(__dir__, 'ftr_solicitudes_localizacion.rb')

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
territorial_groups = Location.where(admin_level: 1).order(:location_code).map do |state|
  state_name = state.placename_es.presence || state.placename_en
  UserGroup.create_or_update!(
    unique_id: "usergroup-lrf-state-#{state.location_code.downcase}",
    name: "LRF - #{state_name}",
    description: "Equipo territorial LRF de #{state_name}",
    agency_unique_ids: [asonacop.unique_id]
  )
end

ftr_worker = Role.create_or_update!(
  unique_id: 'role-ftr-worker',
  name: 'Monitor LRF',
  description: 'Registra y gestiona sus propias solicitudes de localización',
  permissions: [
    Permission.new(
      resource: Permission::TRACING_REQUEST,
      actions: [
        Permission::READ, Permission::CREATE, Permission::WRITE,
        Permission::FLAG, Permission::ENABLE_DISABLE_RECORD,
        Permission::EXPORT_LIST_VIEW, Permission::EXPORT_CSV,
        Permission::EXPORT_EXCEL, Permission::EXPORT_PDF,
        Permission::CHANGE_LOG
      ]
    ),
    Permission.new(
      resource: Permission::POTENTIAL_MATCH,
      actions: [Permission::READ, Permission::VIEW_PHOTO, Permission::VIEW_AUDIO]
    ),
    Permission.new(
      resource: Permission::CASE,
      actions: [Permission::READ, Permission::FIND_TRACING_MATCH]
    )
  ],
  group_permission: Permission::SELF,
  modules: [cp_module],
  form_sections: ftr_forms
)

ftr_manager = Role.create_or_update!(
  unique_id: 'role-ftr-manager',
  name: 'Coordinador LRF',
  description: 'Supervisa las solicitudes de los grupos territoriales asignados',
  permissions: [
    Permission.new(resource: Permission::TRACING_REQUEST, actions: [Permission::MANAGE]),
    Permission.new(
      resource: Permission::POTENTIAL_MATCH,
      actions: [Permission::READ, Permission::VIEW_PHOTO, Permission::VIEW_AUDIO]
    ),
    Permission.new(
      resource: Permission::CASE,
      actions: [Permission::READ, Permission::FIND_TRACING_MATCH]
    ),
    Permission.new(resource: Permission::USER, actions: [Permission::READ]),
    Permission.new(resource: Permission::USER_GROUP, actions: [Permission::READ]),
    Permission.new(resource: Permission::REPORT, actions: [Permission::READ]),
    Permission.new(resource: Permission::DASHBOARD, actions: [Permission::DASH_MATCHING_RESULTS])
  ],
  group_permission: Permission::GROUP,
  is_manager: true,
  modules: [cp_module],
  form_sections: ftr_forms
)

[
  ['primero_ftr', 'Monitor LRF', ftr_worker, 'PRIMERO_FTR_WORKER'],
  ['primero_mgr_ftr', 'Coordinador LRF', ftr_manager, 'PRIMERO_FTR_MANAGER']
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
User.joins(:role).where(roles: { unique_id: %w[role-ftr-worker role-ftr-manager] }).find_each do |user|
  user.update!(agency_id: asonacop.id)
end

User.where(user_name: %w[admin primero]).update_all(locale: 'es')
GenerateLocationFilesJob.perform_now

puts "Loaded #{Location.count} Venezuela locations and configured #{ftr_group.name} with #{territorial_groups.count} territorial groups"
