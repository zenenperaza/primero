# frozen_string_literal: true

# Additional tracing request forms for Venezuela's localization and family
# reunification workflow. Detailed case management remains in linked cases.

def ftr_field(name, type, display_name_en, display_name_es, attributes = {})
  Field.new(
    {
      'name' => name,
      'type' => type,
      'display_name_en' => display_name_en,
      'display_name_es' => display_name_es
    }.merge(attributes)
  )
end

def ftr_options(rows)
  {
    'option_strings_text_en' => rows.map { |id, en, _es| { id:, display_text: en }.with_indifferent_access },
    'option_strings_text_es' => rows.map { |id, _en, es| { id:, display_text: es }.with_indifferent_access }
  }
end

def ftr_form(unique_id, order, form_group_id, name_en, name_es, fields, attributes = {})
  FormSection.create_or_update!(
    {
      unique_id:,
      parent_form: 'tracing_request',
      visible: true,
      order_form_group: order,
      order:,
      order_subform: 0,
      form_group_id:,
      editable: true,
      fields:,
      name_en:,
      name_es:,
      description_en: name_en,
      description_es: name_es
    }.merge(attributes)
  )
end

def ftr_subform(unique_id, order, name_en, name_es, fields, collapsed_field_names)
  FormSection.create_or_update!(
    unique_id:,
    parent_form: 'tracing_request',
    visible: false,
    is_nested: true,
    order_form_group: order,
    order:,
    order_subform: 1,
    editable: true,
    fields:,
    initial_subforms: 0,
    collapsed_field_names:,
    name_en:,
    name_es:,
    description_en: name_en,
    description_es: name_es
  )
end

puts 'Loading Venezuela tracing request workflow forms'

yes_label = { 'tick_box_label_en' => 'Yes', 'tick_box_label_es' => 'Sí' }
risk_levels = ftr_options([
                            %w[high High Alto],
                            %w[medium Medium Medio],
                            %w[low Low Bajo]
                          ])
document_types = ftr_options([
                              ['national_id', 'National identity document', 'Documento nacional de identidad'],
                              ['birth_certificate', 'Birth certificate', 'Partida de nacimiento'],
                              %w[passport Passport Pasaporte],
                              %w[other Other Otro]
                            ])
request_types = ftr_options([
                             ['family_tracing', 'Family tracing', 'Localización familiar'],
                             ['documentation', 'Documentation support', 'Apoyo de documentación'],
                             ['family_evaluation', 'Family evaluation', 'Evaluación familiar'],
                             ['family_reunification', 'Family reunification', 'Reunificación familiar'],
                             ['safe_transit', 'Safe transit', 'Tránsito seguro'],
                             %w[other Other Otro]
                           ])
required_services = ftr_options([
                                 ['family_tracing', 'Family tracing', 'Localización familiar'],
                                 ['documentation', 'Documentation support', 'Apoyo de documentación'],
                                 ['family_evaluation', 'Family evaluation', 'Evaluación familiar'],
                                 ['family_reunification', 'Family reunification', 'Reunificación familiar'],
                                 ['psychosocial_support', 'Psychosocial support', 'Apoyo psicosocial'],
                                 ['case_management', 'Case management', 'Gestión de casos'],
                                 %w[health Health Salud],
                                 %w[food Food Alimentación],
                                 %w[shelter Shelter Alojamiento],
                                 %w[transportation Transportation Transporte],
                                 %w[other Other Otro]
                               ])

admission_fields = [
  ftr_field('ftr_referral_date', 'date_field', 'Referral date', 'Fecha de referencia',
            'selected_value' => 'today'),
  ftr_field('ftr_referral_organization', 'text_field', 'Referring organization',
            'Organización remitente'),
  ftr_field('ftr_referral_location', 'select_box', 'Referral location', 'Ubicación de referencia',
            'option_strings_source' => 'Location'),
  ftr_field('ftr_external_program_code', 'text_field', 'External program code',
            'Código externo del programa'),
  ftr_field('ftr_request_types', 'select_box', 'Request type', 'Tipo de solicitud',
            { 'multi_select' => true }.merge(request_types)),
  ftr_field('ftr_current_situation', 'textarea', 'Current situation and context',
            'Situación actual y contexto'),
  ftr_field('ftr_risk_level', 'select_box', 'Risk level', 'Nivel de riesgo', risk_levels),
  ftr_field('ftr_required_services', 'select_box', 'Required services', 'Servicios requeridos',
            { 'multi_select' => true }.merge(required_services)),
  ftr_field('ftr_case_management_required', 'tick_box', 'Does this request require a linked case?',
            '¿Esta solicitud requiere un caso vinculado?', yes_label),
  ftr_field('ftr_linked_case_reference', 'text_field', 'Linked case reference',
            'Referencia del caso vinculado')
]
ftr_form('tracing_request_venezuela_admission', 15, 'ftr_admission',
         'Admission and Referral', 'Admisión y referencia', admission_fields, mobile_form: true)

# Extend the standard repeatable sought-person form with matching metadata.
sought_person_fields = [
  ftr_field('ftr_sought_birth_date_approximate', 'tick_box', 'Is the birth date approximate?',
            '¿La fecha de nacimiento es aproximada?', yes_label),
  ftr_field('ftr_sought_nationality', 'select_box', 'Nationality', 'Nacionalidad',
            'multi_select' => true, 'option_strings_source' => 'lookup lookup-nationality', 'matchable' => true),
  ftr_field('ftr_sought_document_type', 'select_box', 'Identity document type',
            'Tipo de documento de identidad', document_types),
  ftr_field('ftr_sought_document_number', 'text_field', 'Identity document number',
            'Número del documento de identidad', 'matchable' => true),
  ftr_field('ftr_sought_language', 'select_box', 'Language', 'Idioma',
            'multi_select' => true, 'option_strings_source' => 'lookup lookup-language', 'matchable' => true),
  ftr_field('ftr_sought_ethnicity', 'select_box', 'Ethnicity', 'Etnia',
            'option_strings_source' => 'lookup lookup-ethnicity', 'matchable' => true)
]
sought_person_form = FormSection.find_by!(unique_id: 'tracing_request_subform_section')
sought_person_names = sought_person_fields.map(&:name)
sought_person_form.fields = sought_person_form.fields.reject { |field| sought_person_names.include?(field.name) } +
                            sought_person_fields
sought_person_form.save!

related_person_types = ftr_options([
                                    %w[caregiver Caregiver Cuidador],
                                    ['household_member', 'Household member', 'Persona conviviente'],
                                    ['external_relative', 'External relative', 'Familiar externo'],
                                    ['key_contact', 'Key contact', 'Contacto clave'],
                                    ['important_person', 'Other important person', 'Otra persona importante']
                                  ])
related_people_fields = [
  ftr_field('ftr_related_person_type', 'select_box', 'Person type', 'Tipo de persona', related_person_types),
  ftr_field('ftr_related_person_name', 'text_field', 'Full name', 'Nombres y apellidos'),
  ftr_field('ftr_related_person_relationship', 'select_box', 'Relationship', 'Relación',
            'option_strings_source' => 'lookup lookup-family-relationship'),
  ftr_field('ftr_related_person_date_of_birth', 'date_field', 'Date of birth', 'Fecha de nacimiento',
            'date_validation' => 'not_future_date'),
  ftr_field('ftr_related_person_age', 'numeric_field', 'Age', 'Edad'),
  ftr_field('ftr_related_person_sex', 'select_box', 'Sex', 'Sexo',
            'option_strings_source' => 'lookup lookup-gender'),
  ftr_field('ftr_related_person_document_type', 'select_box', 'Identity document type',
            'Tipo de documento de identidad', document_types),
  ftr_field('ftr_related_person_document_number', 'text_field', 'Identity document number',
            'Número del documento de identidad'),
  ftr_field('ftr_related_person_location', 'select_box', 'Current location', 'Ubicación actual',
            'option_strings_source' => 'Location'),
  ftr_field('ftr_related_person_telephone', 'text_field', 'Telephone', 'Teléfono'),
  ftr_field('ftr_related_person_lives_with_sought_person', 'tick_box',
            'Does this person live with the sought person?',
            '¿Esta persona convive con la persona buscada?', yes_label),
  ftr_field('ftr_related_person_contact_consent', 'tick_box', 'Consent to contact',
            'Consentimiento para contactar', yes_label),
  ftr_field('ftr_related_person_notes', 'textarea', 'Notes', 'Observaciones')
]
related_people_subform = ftr_subform(
  'tracing_request_venezuela_related_people_subform', 35,
  'Nested Related People', 'Personas vinculadas', related_people_fields,
  %w[ftr_related_person_name ftr_related_person_relationship]
)
ftr_form(
  'tracing_request_venezuela_related_people', 35, 'ftr_related_people',
  'Related People', 'Personas vinculadas',
  [ftr_field('ftr_related_people', 'subform', 'Related people', 'Personas vinculadas',
             'subform_section' => related_people_subform)]
)

care_arrangements = ftr_options([
                                 %w[parents Parents Padres],
                                 %w[relative Relative Familiar],
                                 ['foster_family', 'Foster family', 'Familia de acogida'],
                                 ['residential_care', 'Residential care', 'Cuidado residencial'],
                                 ['independent', 'Independent living', 'Vida independiente'],
                                 ['unrelated_adult', 'Unrelated adult', 'Adulto sin parentesco'],
                                 ['without_care', 'Without care', 'Sin cuidado'],
                                 %w[other Other Otro]
                               ])
caregiver_disposition = ftr_options([
                                     ['short_term', 'Short-term', 'Corto plazo'],
                                     ['long_term', 'Long-term', 'Largo plazo'],
                                     ['not_willing', 'Not willing', 'No dispuesto'],
                                     %w[unknown Unknown Desconocido]
                                   ])
care_fields = [
  ftr_field('ftr_current_care_arrangement', 'select_box', 'Current care arrangement',
            'Modalidad de cuidado actual', care_arrangements),
  ftr_field('ftr_primary_caregiver_name', 'text_field', 'Primary caregiver name',
            'Nombre del cuidador principal'),
  ftr_field('ftr_primary_caregiver_relationship', 'select_box', 'Primary caregiver relationship',
            'Relación del cuidador principal', 'option_strings_source' => 'lookup lookup-family-relationship'),
  ftr_field('ftr_care_since', 'date_field', 'Care arrangement start date',
            'Fecha de inicio del cuidado', 'date_validation' => 'not_future_date'),
  ftr_field('ftr_caregiver_disposition', 'select_box', 'Caregiver disposition',
            'Disposición del cuidador', caregiver_disposition),
  ftr_field('ftr_family_contacts_available', 'tick_box', 'Are family contacts available?',
            '¿Existen contactos familiares disponibles?', yes_label),
  ftr_field('ftr_reunification_plan', 'textarea', 'Planned reunification or transfer',
            'Reunificación o traslado previsto'),
  ftr_field('ftr_reunification_location', 'select_box', 'Planned reunification location',
            'Ubicación prevista para la reunificación', 'option_strings_source' => 'Location'),
  ftr_field('ftr_reunification_notes', 'textarea', 'Reunification notes',
            'Observaciones de reunificación')
]
ftr_form('tracing_request_venezuela_care_reunification', 40, 'ftr_care_reunification',
         'Care and Reunification', 'Cuidado y reunificación', care_fields)

protection_alerts = ftr_options([
                                 ['physical_abuse', 'Physical abuse', 'Maltrato físico'],
                                 ['sexual_abuse', 'Sexual abuse', 'Abuso sexual'],
                                 ['psychological_abuse', 'Psychological or emotional abuse',
                                  'Maltrato psicológico o emocional'],
                                 %w[neglect Neglect Negligencia],
                                 %w[abandonment Abandonment Abandono],
                                 ['child_labour', 'Child labour', 'Trabajo infantil'],
                                 ['exploitation_or_trafficking', 'Exploitation or trafficking', 'Explotación o trata'],
                                 ['unaccompanied_or_separated', 'Unaccompanied or separated child',
                                  'NNA no acompañado o separado'],
                                 ['serious_medical_condition', 'Serious medical condition', 'Condición médica grave'],
                                 ['missing_documents', 'Missing documents', 'Falta de documentos'],
                                 ['risky_care_arrangement', 'Risky care arrangement', 'Modalidad de cuidado riesgosa'],
                                 %w[other Other Otro]
                               ])
response_areas = ftr_options([
                              %w[health Health Salud],
                              %w[security Security Seguridad],
                              ['temporary_care', 'Temporary care', 'Cuidado temporal'],
                              %w[documentation Documentation Documentación],
                              ['psychosocial_support', 'Psychosocial support', 'Apoyo psicosocial'],
                              %w[food Food Alimentación],
                              %w[shelter Shelter Alojamiento],
                              %w[transportation Transportation Transporte],
                              %w[other Other Otra]
                            ])
alert_fields = [
  ftr_field('ftr_protection_alerts', 'select_box', 'Protection alerts', 'Alertas de protección',
            { 'multi_select' => true }.merge(protection_alerts)),
  ftr_field('ftr_updated_risk_level', 'select_box', 'Updated risk level', 'Nivel de riesgo actualizado', risk_levels),
  ftr_field('ftr_immediate_response_required', 'tick_box', 'Is an immediate response required?',
            '¿Se requiere respuesta inmediata?', yes_label),
  ftr_field('ftr_immediate_response_areas', 'select_box', 'Immediate response areas',
            'Áreas de respuesta inmediata', { 'multi_select' => true }.merge(response_areas)),
  ftr_field('ftr_immediate_action', 'textarea', 'Action or referral applied', 'Acción o referencia aplicada'),
  ftr_field('ftr_alert_notes', 'textarea', 'Notes', 'Observaciones')
]
ftr_form('tracing_request_venezuela_alerts', 50, 'ftr_alerts',
         'Alerts and Immediate Response', 'Alertas y respuesta inmediata', alert_fields)

signer_types = ftr_options([
                            ['adult_sought_person', 'Adult sought person', 'Persona buscada adulta'],
                            %w[parent Parent Representante],
                            %w[caregiver Caregiver Cuidador],
                            ['legal_representative', 'Legal representative', 'Representante legal'],
                            %w[other Other Otro]
                          ])
consent_fields = [
  ftr_field('ftr_informed_consent_obtained', 'tick_box', 'Was informed consent obtained?',
            '¿Se obtuvo consentimiento informado?', yes_label),
  ftr_field('ftr_consent_date', 'date_field', 'Consent date', 'Fecha del consentimiento',
            'date_validation' => 'not_future_date'),
  ftr_field('ftr_consent_signer_type', 'select_box', 'Signer type', 'Tipo de firmante', signer_types),
  ftr_field('ftr_authorizes_contact', 'tick_box', 'Authorizes contact', 'Autoriza contacto', yes_label),
  ftr_field('ftr_authorizes_information_storage', 'tick_box',
            'Authorizes information collection and storage',
            'Autoriza recolección y almacenamiento de información', yes_label),
  ftr_field('ftr_authorizes_service_provider_sharing', 'tick_box',
            'Authorizes sharing information with service providers',
            'Autoriza compartir información con prestadores de servicios', yes_label),
  ftr_field('ftr_authorizes_image_use', 'tick_box', 'Authorizes image use', 'Autoriza uso de imagen', yes_label),
  ftr_field('ftr_consent_restrictions', 'textarea', 'Restrictions or exceptions', 'Restricciones o excepciones'),
  ftr_field('ftr_child_assent', 'tick_box', 'Child assent, when applicable',
            'Asentimiento del NNA, cuando corresponda', yes_label),
  ftr_field('ftr_signed_consent_documents', 'document_upload_box', 'Signed consent documents',
            'Documentos de consentimiento firmados',
            'help_text_en' => 'Upload signed consent documents only',
            'help_text_es' => 'Cargue solamente documentos de consentimiento firmados')
]
ftr_form('tracing_request_venezuela_consents', 60, 'ftr_consents',
         'Consents and Authorizations', 'Consentimientos y autorizaciones', consent_fields,
         display_help_text_view: true)

action_types = ftr_options([
                            ['contact_attempt', 'Contact attempt', 'Intento de contacto'],
                            ['document_review', 'Document review', 'Revisión documental'],
                            %w[interview Interview Entrevista],
                            ['home_visit', 'Home visit', 'Visita domiciliaria'],
                            ['institutional_coordination', 'Institutional coordination', 'Coordinación institucional'],
                            %w[referral Referral Referencia],
                            %w[other Other Otra]
                          ])
action_outcomes = ftr_options([
                               %w[pending Pending Pendiente],
                               %w[successful Successful Exitosa],
                               ['unsuccessful', 'Unsuccessful', 'No exitosa'],
                               ['follow_up_required', 'Follow-up required', 'Requiere seguimiento']
                             ])
action_fields = [
  ftr_field('ftr_action_date', 'date_field', 'Date', 'Fecha', 'selected_value' => 'today'),
  ftr_field('ftr_action_type', 'select_box', 'Action type', 'Tipo de actuación', action_types),
  ftr_field('ftr_action_organization', 'text_field', 'Organization or responsible person',
            'Organización o responsable'),
  ftr_field('ftr_action_location', 'select_box', 'Location', 'Ubicación', 'option_strings_source' => 'Location'),
  ftr_field('ftr_action_description', 'textarea', 'Description', 'Descripción'),
  ftr_field('ftr_action_outcome', 'select_box', 'Outcome', 'Resultado', action_outcomes),
  ftr_field('ftr_action_next_step', 'textarea', 'Next action', 'Próxima acción')
]
actions_subform = ftr_subform('tracing_request_venezuela_actions_subform', 70,
                              'Nested Tracing Actions', 'Actuaciones de localización', action_fields,
                              %w[ftr_action_date ftr_action_type ftr_action_outcome])
ftr_form(
  'tracing_request_venezuela_actions', 70, 'ftr_actions',
  'Tracing Actions', 'Actuaciones de localización',
  [ftr_field('ftr_actions', 'subform', 'Tracing actions', 'Actuaciones de localización',
             'subform_section' => actions_subform, 'subform_sort_by' => 'ftr_action_date')]
)

support_types = ftr_options([
                             ['hygiene_kit', 'Hygiene kit', 'Kit de higiene'],
                             ['food_basket', 'Food basket', 'Cesta de alimentos'],
                             %w[transportation Transportation Transporte],
                             ['documentation', 'Documentation support', 'Apoyo de documentación'],
                             ['health', 'Health support', 'Apoyo de salud'],
                             %w[other Other Otro]
                           ])
support_fields = [
  ftr_field('ftr_support_date', 'date_field', 'Delivery date', 'Fecha de entrega',
            'selected_value' => 'today'),
  ftr_field('ftr_support_type', 'select_box', 'Support type', 'Tipo de apoyo', support_types),
  ftr_field('ftr_support_description', 'textarea', 'Description', 'Descripción'),
  ftr_field('ftr_support_quantity', 'numeric_field', 'Quantity', 'Cantidad'),
  ftr_field('ftr_support_organization', 'text_field', 'Responsible organization', 'Organización responsable'),
  ftr_field('ftr_support_notes', 'textarea', 'Notes', 'Observaciones')
]
supports_subform = ftr_subform('tracing_request_venezuela_supports_subform', 80,
                               'Nested Delivered Supports', 'Apoyos entregados', support_fields,
                               %w[ftr_support_date ftr_support_type])
ftr_form(
  'tracing_request_venezuela_supports', 80, 'ftr_supports',
  'Delivered Supports', 'Apoyos entregados',
  [ftr_field('ftr_supports', 'subform', 'Delivered supports', 'Apoyos entregados',
             'subform_section' => supports_subform, 'subform_sort_by' => 'ftr_support_date')]
)

documents_help = {
  'help_text_en' => 'Upload only documents authorized for this tracing request',
  'help_text_es' => 'Cargue solamente documentos autorizados para esta solicitud de localización'
}
document_fields = [
  ftr_field('ftr_document_notes', 'textarea', 'Document classification and notes',
            'Clasificación y observaciones de los documentos'),
  ftr_field('ftr_documents', 'document_upload_box', 'Documents and supports', 'Documentos y soportes', documents_help)
]
ftr_form('tracing_request_venezuela_documents', 90, 'ftr_documents',
         'Documents and Supports', 'Documentos y soportes', document_fields,
         display_help_text_view: true)

form_group_labels = {
  'record_owner' => ['Record Owner', 'Responsable del registro'],
  'inquirer' => ['Inquirer', 'Solicitante'],
  'tracing_request' => ['Tracing Request', 'Solicitud de localización'],
  'photos_audio' => ['Photos and Audio', 'Fotos y audio'],
  'other_reportable_fields' => ['Other Reportable Fields', 'Otros campos de reporte'],
  'ftr_admission' => ['Admission and Referral', 'Admisión y referencia'],
  'ftr_related_people' => ['Related People', 'Personas vinculadas'],
  'ftr_care_reunification' => ['Care and Reunification', 'Cuidado y reunificación'],
  'ftr_alerts' => ['Alerts and Immediate Response', 'Alertas y respuesta inmediata'],
  'ftr_consents' => ['Consents and Authorizations', 'Consentimientos y autorizaciones'],
  'ftr_actions' => ['Tracing Actions', 'Actuaciones de localización'],
  'ftr_supports' => ['Delivered Supports', 'Apoyos entregados'],
  'ftr_documents' => ['Documents and Supports', 'Documentos y soportes']
}
form_group_lookup = Lookup.find_by!(unique_id: 'lookup-form-group-cp-tracing-request')
form_group_lookup.update_translations(:en, 'lookup_values' => form_group_labels.transform_values(&:first))
form_group_lookup.update_translations(:es, 'lookup_values' => form_group_labels.transform_values(&:last))
form_group_lookup.save!

# The tracing request screen loads forms through the active Primero module.
# Applying this file alone to an existing local demo must refresh that link too.
cp_module = PrimeroModule.cp
cp_module.update!(form_sections: cp_module.form_sections | FormSection.where(parent_form: 'tracing_request'))

Role.where(unique_id: %w[role-ftr-worker role-ftr-manager]).find_each do |role|
  role.update!(form_sections: FormSection.where(parent_form: 'tracing_request'))
end

# Superusers are seeded with every existing form. Refresh that association when
# this workflow adds forms after the standard seed process has completed.
Role.where(unique_id: 'role-superuser').find_each(&:associate_all_forms)
