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

puts 'Configuring FTR roles, group and users'
cp_module = PrimeroModule.cp
unicef = Agency.find_by!(agency_code: 'UNICEF')
ftr_forms = FormSection.where(parent_form: 'tracing_request')
ftr_group = UserGroup.create_or_update!(
  unique_id: 'usergroup-primero-ftr',
  name: 'Primero FTR',
  description: 'Solicitudes de Localización - Venezuela',
  agency_unique_ids: ['UNICEF']
)

ftr_worker = Role.create_or_update!(
  unique_id: 'role-ftr-worker',
  name: 'FTR Worker',
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
  modules: [cp_module],
  form_sections: ftr_forms
)

ftr_manager = Role.create_or_update!(
  unique_id: 'role-ftr-manager',
  name: 'FTR Manager',
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
  ['primero_ftr', 'FTR Worker', ftr_worker, 'PRIMERO_FTR_WORKER'],
  ['primero_mgr_ftr', 'FTR Manager', ftr_manager, 'PRIMERO_FTR_MANAGER']
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
    'agency_id' => unicef.id,
    'role_id' => role.id,
    'user_groups' => [ftr_group],
    'locale' => 'es'
  )
  user.save!
end

User.where(user_name: %w[admin primero]).update_all(locale: 'es')
GenerateLocationFilesJob.perform_now

puts "Loaded #{Location.count} Venezuela locations and configured #{ftr_group.name}"
