# frozen_string_literal: true

# Removes the archived Venezuela LRF custom forms from Tracing Requests while
# keeping Primero's standard tracing request forms.

custom_form_ids = FormSection.where(parent_form: 'tracing_request')
                             .where("unique_id LIKE 'tracing_request_venezuela_%'")
                             .pluck(:unique_id)
ftr_form_group_ids = %w[
  ftr_admission
  ftr_related_people
  ftr_care_reunification
  ftr_alerts
  ftr_consents
  ftr_actions
  ftr_supports
  ftr_documents
]
removed_standard_fields = []

FormSection.transaction do
  standard_section = FormSection.find_by(unique_id: 'tracing_request_subform_section')

  if standard_section
    original_fields = standard_section.fields || []
    kept_fields = original_fields.reject do |field|
      remove = field['name'].to_s.start_with?('ftr_')
      removed_standard_fields << field['name'] if remove
      remove
    end
    standard_section.update!(fields: kept_fields) if kept_fields != original_fields
  end

  Lookup.where(unique_id: 'lookup-form-group-cp-tracing-request').find_each do |lookup|
    values = lookup.lookup_values_i18n || []
    filtered = values.reject { |value| ftr_form_group_ids.include?(value['id'] || value[:id]) }
    lookup.update!(lookup_values_i18n: filtered) if filtered != values
  end

  FormSection.where(unique_id: custom_form_ids).find_each do |section|
    section.roles.clear
    section.primero_modules.clear if section.respond_to?(:primero_modules)
    section.destroy!
  end
end

puts "Removed #{custom_form_ids.count} LRF tracing request form sections"
puts "Removed #{removed_standard_fields.count} LRF fields from tracing_request_subform_section"
