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
load File.join(__dir__, 'lrf_role_permissions.rb')
# The custom LRF Tracing Request forms are backed up in
# ftr_solicitudes_localizacion.rb and can be loaded later when the workflow is
# ready to be installed again.

puts 'Configuring English base language and Spanish translations'
SystemSettings.current.update!(
  base_language: 'en',
  default_locale: 'es',
  locales: %w[en es],
  approvals_labels_i18n: {
    en: {
      closure: 'Closure',
      case_plan: 'Case Plan',
      assessment: 'Assessment',
      action_plan: 'Action Plan',
      gbv_closure: 'GBV Closure'
    },
    es: {
      closure: 'Cierre',
      case_plan: 'Plan de Caso',
      assessment: "Evaluaci\u00F3n",
      action_plan: "Plan de Acci\u00F3n",
      gbv_closure: 'Cierre VBG'
    }
  }
)

puts 'Enabling Case and Tracing Request attachments'
editable_attachment_sections = {
  'photos_and_audio' => %w[photos recorded_audio],
  'tracing_request_photos_and_audio' => %w[photos recorded_audio],
  'other_documents' => %w[other_documents]
}

editable_attachment_sections.each do |section_id, field_names|
  media_section = FormSection.find_by!(unique_id: section_id)
  media_fields = media_section.fields.map do |field|
    if field_names.include?(field['name'])
      field['editable'] = true
      field['disabled'] = false
    end
    field
  end
  media_section.update!(editable: true, fields: media_fields)
end

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

puts 'Loading Venezuela states, municipalities and parishes'
system_settings = SystemSettings.current
system_settings.update!(
  reporting_location_config: {
    field_key: 'owned_by_location',
    admin_level: 1,
    admin_level_map: { '1' => ['state'], '2' => ['municipality'], '3' => ['parish'] }
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

lrf_roles = VenezuelaLrfRolePermissions.apply!
lrf_field_coordinator = lrf_roles.fetch(:field_coordinator)
lrf_manager = lrf_roles.fetch(:manager)

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
