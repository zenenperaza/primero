# frozen_string_literal: true

# ASONACOP Localization and Family Reunification forms.
# This file keeps the local adaptation separate from Primero's standard CP
# forms. Tracing Requests cover intake, localization and referral. Linked Cases
# cover sustained follow-up and closure.

def lrf_field(name, type, display_name_en, display_name_es, attributes = {})
  Field.new(
    {
      'name' => name,
      'type' => type,
      'display_name_en' => display_name_en,
      'display_name_es' => display_name_es
    }.merge(attributes)
  )
end

def lrf_options(rows)
  {
    'option_strings_text_en' => rows.map { |id, en, _es| { id:, display_text: en }.with_indifferent_access },
    'option_strings_text_es' => rows.map { |id, _en, es| { id:, display_text: es }.with_indifferent_access }
  }
end

def lrf_form(unique_id, parent_form, order, form_group_id, name_en, name_es, fields, attributes = {})
  FormSection.create_or_update!(
    {
      unique_id:,
      parent_form:,
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

def lrf_subform(unique_id, parent_form, order, name_en, name_es, fields, collapsed_field_names)
  FormSection.create_or_update!(
    unique_id:,
    parent_form:,
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

puts 'Loading ASONACOP LRF forms'

yes_no = lrf_options([
                       %w[yes Yes Si],
                       %w[no No No]
                     ])
yes_no_unable = lrf_options([
                              %w[yes Yes Si],
                              %w[no No No],
                              ['unable_to_determine', 'Unable to determine', 'Incapaz de determinar']
                            ])
priority = lrf_options([
                         %w[high High Alta],
                         %w[medium Medium Media],
                         %w[low Low Baja]
                       ])
sex = lrf_options([
                    %w[male Male Masculino],
                    %w[female Female Femenino],
                    %w[other Other Otro],
                    %w[unknown Unknown Desconocido]
                  ])
document_types = lrf_options([
                              ['national_id', 'National identity document', 'Cedula de identidad'],
                              ['birth_certificate', 'Birth certificate', 'Partida de nacimiento'],
                              %w[passport Passport Pasaporte],
                              ['no_document', 'No document', 'Sin documento'],
                              %w[other Other Otro]
                            ])
migration_status = lrf_options([
                                 %w[regular Regular Regular],
                                 %w[irregular Irregular Irregular],
                                 ['not_applicable', 'Not applicable', 'No aplica'],
                                 %w[unknown Unknown Desconocido]
                               ])
entry_method = lrf_options([
                             ['official_crossing', 'Official crossing', 'Paso regular'],
                             ['informal_crossing', 'Informal crossing', 'Paso irregular'],
                             ['humanitarian_corridor', 'Humanitarian corridor', 'Corredor humanitario'],
                             ['not_applicable', 'Not applicable', 'No aplica'],
                             %w[unknown Unknown Desconocido],
                             %w[other Other Otro]
                           ])
referral_channel = lrf_options([
                                 %w[phone Phone Telefono],
                                 %w[email Email Correo],
                                 ['in_person', 'In person', 'En persona'],
                                 %w[other Other Otro]
                               ])
referral_reason = lrf_options([
                                ['family_tracing', 'Localization', 'Localizacion'],
                                ['family_reunification', 'Family reunification', 'Reunificacion familiar'],
                                %w[other Other Otro]
                              ])
protection_needs = lrf_options([
                                 ['child_with_disability', 'Child with disability', 'NNA con discapacidad'],
                                 ['physical_disability', 'Physical disability', 'Discapacidad fisica'],
                                 ['mental_disability', 'Mental disability', 'Discapacidad mental'],
                                 ['serious_medical_condition', 'Serious medical condition', 'Condicion medica grave'],
                                 ['chronic_illness', 'Chronic illness', 'Enfermedad cronica'],
                                 ['other_serious_illness', 'Other serious illness', 'Otras enfermedades graves'],
                                 ['gbv_risk', 'Risk of GBV', 'NNA en riesgo de VBG'],
                                 ['early_pregnancy', 'Early pregnancy', 'Embarazo temprano'],
                                 ['family_violence', 'Family violence', 'Violencia intrafamiliar'],
                                 ['legal_or_physical_protection', 'Legal or physical protection need',
                                  'Necesidades de proteccion legal y/o fisica'],
                                 ['no_legal_documentation', 'No legal documentation', 'Sin documentacion legal'],
                                 ['trafficking', 'Victim of trafficking or smuggling', 'Victima de trata o trafico de persona'],
                                 ['child_labour', 'Child labour', 'Trabajo infantil'],
                                 ['forced_recruitment', 'Forced recruitment', 'Reclutamiento forzoso'],
                                 ['unaccompanied_child', 'Unaccompanied child', 'Nino no acompanado'],
                                 ['separated_child', 'Separated child', 'Nino separado'],
                                 ['sexual_abuse_or_exploitation', 'Sexual abuse or exploitation',
                                  'Victima de abuso o explotacion sexual'],
                                 ['lgbti_risk', 'LGBTI+ person at risk', 'Persona LGBTI+ en riesgo'],
                                 ['indigenous_or_minority', 'Indigenous or minority group',
                                  'Grupos indigenas o minoritarios'],
                                 ['school_age_not_attending', 'School age and not attending school',
                                  'En edad escolar y no asiste a la escuela'],
                                 ['emotional_distress', 'Emotional distress', 'Estres emocional'],
                                 %w[other Other Otro]
                               ])
services_required = lrf_options([
                                  ['child_protection', 'Child protection', 'Proteccion de la infancia'],
                                  %w[education Education Educacion],
                                  %w[gbv GBV VBG],
                                  ['health_services', 'Health and health services', 'Salud y servicios de salud'],
                                  ['psychosocial_support', 'Psychosocial support', 'Apoyo psicosocial'],
                                  ['identity_documents', 'Identity document support',
                                   'Apoyo para documentos de identidad'],
                                  ['food_security', 'Food security / nutrition', 'Seguridad alimentaria/nutricion'],
                                  %w[shelter Shelter Vivienda],
                                  ['legal_services', 'Legal counselling or services', 'Asesoria y/o servicios legales'],
                                  ['physical_security', 'Physical security / safe emergency shelter',
                                   'Seguridad fisica o alojamiento seguro'],
                                  ['transport_logistics', 'Transport logistics support',
                                   'Apoyo logistico para traslado'],
                                  %w[other Other Otro]
                                ])
approach_types = lrf_options([
                               ['voluntary_presentation', 'Voluntary presentation to migration/protection office',
                                'Se presento voluntariamente en oficina migratoria o de proteccion'],
                               ['security_body', 'Brought by security body', 'Fue llevado por cuerpos de seguridad'],
                               ['child_protection_authority', 'Intervention by child protection authority',
                                'Intervenido por organo de proteccion de NNA'],
                               ['humanitarian_organization', 'Requested support from humanitarian organization',
                                'Solicito apoyo a una organizacion humanitaria'],
                               ['migration_operation', 'Found during migration operation',
                                'Encontrado en operativo migratorio'],
                               ['third_person_support', 'Supported by a third person', 'Apoyado por tercera persona'],
                               %w[other Other Otro]
                             ])

tracing_fields = [
  lrf_field('lrf_asonacop_source_form', 'select_box', 'Source paper form', 'Planilla fisica de origen',
            lrf_options([
                          ['registration', 'No. 1 Case registration', 'No. 1 Registro de casos'],
                          ['derivation', 'No. 2 Case referral', 'No. 2 Derivacion de casos']
                        ])),
  lrf_field('lrf_asonacop_institution', 'text_field', 'Organization or institution', 'Organismo o institucion'),
  lrf_field('lrf_asonacop_form_date', 'date_field', 'Form date', 'Fecha'),
  lrf_field('lrf_asonacop_reception_date', 'date_field', 'Case reception date', 'Fecha de recepcion del caso'),
  lrf_field('lrf_asonacop_child_full_name', 'text_field', 'Child full name', 'Nombres y apellidos del NNA',
            'matchable' => true),
  lrf_field('lrf_asonacop_child_sex', 'select_box', 'Sex', 'Sexo', sex.merge('matchable' => true)),
  lrf_field('lrf_asonacop_child_date_of_birth', 'date_field', 'Date of birth', 'Fecha de nacimiento',
            'date_validation' => 'not_future_date', 'matchable' => true),
  lrf_field('lrf_asonacop_child_age', 'numeric_field', 'Age', 'Edad', 'matchable' => true),
  lrf_field('lrf_asonacop_child_document_type', 'select_box', 'Identity document type',
            'Tipo de identificacion', document_types),
  lrf_field('lrf_asonacop_child_document_number', 'text_field', 'Identity document number',
            'Numero de identificacion', 'matchable' => true),
  lrf_field('lrf_asonacop_child_nationality', 'select_box', 'Nationality', 'Nacionalidad',
            'option_strings_source' => 'lookup lookup-nationality', 'multi_select' => true, 'matchable' => true),
  lrf_field('lrf_asonacop_child_phone', 'text_field', 'Phone number', 'Numero de telefono'),
  lrf_field('lrf_asonacop_current_address', 'textarea', 'Current address', 'Direccion actual'),
  lrf_field('lrf_asonacop_family_members_total', 'numeric_field', 'Number of family members',
            'Numero de miembros de la familia'),
  lrf_field('lrf_asonacop_family_male_over_60', 'numeric_field', 'Male 60+', 'Hombre +60'),
  lrf_field('lrf_asonacop_family_male_18_59', 'numeric_field', 'Male 18-59', 'Hombre 18-59'),
  lrf_field('lrf_asonacop_family_female_over_60', 'numeric_field', 'Female 60+', 'Mujer +60'),
  lrf_field('lrf_asonacop_family_female_18_59', 'numeric_field', 'Female 18-59', 'Mujer 18-59'),
  lrf_field('lrf_asonacop_family_boy_13_17', 'numeric_field', 'Boy 13-17', 'Nino 13-17'),
  lrf_field('lrf_asonacop_family_boy_6_12', 'numeric_field', 'Boy 6-12', 'Nino 6-12'),
  lrf_field('lrf_asonacop_family_boy_0_5', 'numeric_field', 'Boy 0-5', 'Nino 0-5'),
  lrf_field('lrf_asonacop_family_girl_13_17', 'numeric_field', 'Girl 13-17', 'Nina 13-17'),
  lrf_field('lrf_asonacop_family_girl_6_12', 'numeric_field', 'Girl 6-12', 'Nina 6-12'),
  lrf_field('lrf_asonacop_family_girl_0_5', 'numeric_field', 'Girl 0-5', 'Nina 0-5'),
  lrf_field('lrf_asonacop_caregiver_name', 'text_field', 'Caregiver name', 'Nombre del cuidador/a'),
  lrf_field('lrf_asonacop_migration_status', 'select_box', 'Migration status', 'Condicion migratoria',
            migration_status),
  lrf_field('lrf_asonacop_country_of_origin', 'select_box', 'Country of origin', 'Pais de procedencia',
            'option_strings_source' => 'lookup lookup-country'),
  lrf_field('lrf_asonacop_entry_date', 'date_field', 'Entry date', 'Fecha de ingreso',
            'date_validation' => 'not_future_date'),
  lrf_field('lrf_asonacop_entry_method', 'select_box', 'Entry method', 'Forma de ingreso', entry_method),
  lrf_field('lrf_asonacop_place_stayed', 'textarea', 'Place where the child stayed',
            'Lugar donde permanecia'),
  lrf_field('lrf_asonacop_has_family_link', 'radio_button', 'Has any family relationship link?',
            'Tiene algun vinculo por parentesco', yes_no),
  lrf_field('lrf_asonacop_family_link_detail', 'text_field', 'Specify relationship link', 'Indique cual'),
  lrf_field('lrf_asonacop_parent_responsible_name', 'text_field',
            'Parent, representative or responsible adult name',
            'Nombre del progenitor, representante o responsable'),
  lrf_field('lrf_asonacop_parent_responsible_document', 'text_field', 'Responsible adult identity document',
            'Cedula de identidad del responsable'),
  lrf_field('lrf_asonacop_parent_responsible_residence', 'textarea', 'Responsible adult residence',
            'Lugar de residencia del responsable'),
  lrf_field('lrf_asonacop_parent_responsible_phone', 'text_field', 'Responsible adult phone',
            'Numero de telefono del responsable'),
  lrf_field('lrf_asonacop_protection_needs', 'select_box', 'Specific protection needs',
            'Necesidades especificas de proteccion', protection_needs.merge('multi_select' => true)),
  lrf_field('lrf_asonacop_protection_needs_other', 'text_field', 'Other protection need',
            'Otra necesidad de proteccion'),
  lrf_field('lrf_asonacop_referral_motives', 'textarea', 'Referral motives and recommendations',
            'Motivos de remision y recomendaciones'),
  lrf_field('lrf_asonacop_approach_type', 'select_box', 'How the child was approached',
            'Como fue abordado el NNA', approach_types.merge('multi_select' => true)),
  lrf_field('lrf_asonacop_approach_details', 'textarea', 'Approach details', 'Detalles del abordaje'),
  lrf_field('lrf_asonacop_services_required', 'select_box', 'Required services', 'Servicios requeridos',
            services_required.merge('multi_select' => true)),
  lrf_field('lrf_asonacop_assistance_already_provided', 'textarea',
            'Assistance already provided and by whom',
            'Servicio o asistencia ya brindada y por parte de quien'),
  lrf_field('lrf_asonacop_quick_reunification_probability', 'radio_button',
            'High probability of quick reunification',
            'Alta probabilidad de reunificacion rapida', yes_no),
  lrf_field('lrf_asonacop_high_immediate_vulnerability', 'radio_button',
            'High immediate vulnerability or protection risk',
            'Alto nivel de vulnerabilidad inmediata o riesgo de proteccion', yes_no),
  lrf_field('lrf_asonacop_referral_from_name', 'text_field', 'Referral made by - name',
            'Remision hecha por - nombre'),
  lrf_field('lrf_asonacop_referral_from_organization', 'text_field', 'Referral made by - organization',
            'Remision hecha por - organizacion'),
  lrf_field('lrf_asonacop_referral_from_official', 'text_field', 'Official name',
            'Nombre del funcionario'),
  lrf_field('lrf_asonacop_referral_from_position', 'text_field', 'Position', 'Cargo'),
  lrf_field('lrf_asonacop_referral_from_contact', 'text_field', 'Phone and email',
            'Telefono y correo'),
  lrf_field('lrf_asonacop_priority', 'select_box', 'Priority', 'Prioridad', priority),
  lrf_field('lrf_asonacop_referral_date', 'date_field', 'Referral date', 'Fecha de remision',
            'date_validation' => 'not_future_date'),
  lrf_field('lrf_asonacop_referral_channel', 'select_box', 'Referral channel', 'Medio de remision',
            referral_channel.merge('multi_select' => true)),
  lrf_field('lrf_asonacop_assessment_done', 'radio_button', 'Has an assessment been completed?',
            'Se ha hecho una evaluacion', yes_no),
  lrf_field('lrf_asonacop_assessed_by', 'text_field', 'If yes, by whom?', 'En caso afirmativo, quien'),
  lrf_field('lrf_asonacop_referral_to_name', 'text_field', 'Referral made to - name',
            'Remision hecha a - nombre'),
  lrf_field('lrf_asonacop_referral_to_organization', 'text_field', 'Referral made to - organization',
            'Remision hecha a - organizacion'),
  lrf_field('lrf_asonacop_referral_to_place', 'text_field', 'Referral made to - place',
            'Remision hecha a - lugar'),
  lrf_field('lrf_asonacop_referral_main_reason', 'select_box', 'Main referral reason',
            'Razon principal de la referencia', referral_reason),
  lrf_field('lrf_asonacop_referral_observation', 'textarea', 'Observation', 'Observacion'),
  lrf_field('lrf_asonacop_referrer_explained_process', 'radio_button',
            'Did the referring organization explain the referral process?',
            'La organizacion remitente explico el procedimiento de remision', yes_no),
  lrf_field('lrf_asonacop_consent_to_share_data', 'radio_button',
            'Was informed consent obtained to share individual data?',
            'Se obtuvo consentimiento informado para compartir datos individuales', yes_no),
  lrf_field('lrf_asonacop_caregiver_consent', 'radio_button',
            'For a minor, was parent/caregiver consent obtained?',
            'Para menor de edad, se obtuvo consentimiento del padre/madre/cuidador', yes_no),
  lrf_field('lrf_asonacop_signature_received', 'tick_box', 'Signature received',
            'Firma recibida', 'tick_box_label_en' => 'Yes', 'tick_box_label_es' => 'Si')
]

lrf_form(
  'tracing_request_asonacop_registration_referral', 'tracing_request', 16, 'ftr_admission',
  'ASONACOP Registration and Referral', 'ASONACOP Registro y derivacion',
  tracing_fields, mobile_form: true, display_help_text_view: true
)

followup_with = lrf_options([
                              ['child', 'Child', 'NNA'],
                              ['parent_representative_responsible', 'Parent, representative or responsible adult',
                               'Padre, madre, representante o responsable'],
                              ['own_protection_provider', 'Protection provider from own institution',
                               'Proveedor de servicio de proteccion de la propia institucion'],
                              ['external_protection_provider', 'External protection provider',
                               'Proveedor de servicio de proteccion derivado'],
                              %w[other Other Otro]
                            ])
followup_methods = lrf_options([
                                 %w[phone_call Phone Llamada],
                                 ['instant_message', 'Instant messaging / SMS / WhatsApp',
                                  'Mensajeria instantanea, SMS o WhatsApp'],
                                 %w[email Email Correo],
                                 ['social_media', 'Social media', 'Redes sociales'],
                                 ['unannounced_home_visit', 'Unannounced home visit', 'Visita al hogar sin cita'],
                                 ['scheduled_home_visit', 'Scheduled home visit', 'Visita al hogar bajo cita'],
                                 ['in_person_outside_home', 'In person outside home',
                                  'Encuentro en persona fuera del hogar'],
                                 ['in_person_with_provider_family', 'In person with provider and family',
                                  'Encuentro con proveedor y familia'],
                                 ['in_person_provider_only', 'In person with provider only',
                                  'Encuentro solo con proveedor'],
                                 ['community_group', 'Community group', 'Grupo comunitario'],
                                 ['child_protection_authority', 'Child protection authority',
                                  'Organo administrativo de proteccion de NNA'],
                                 %w[other Other Otro]
                               ])
situation_change = lrf_options([
                                 ['improved', 'Improved', 'Mejoro'],
                                 ['worsened', 'Worsened', 'Empeoro'],
                                 ['no_change', 'No considerable change', 'Sin cambio considerable'],
                                 ['unable_to_determine', 'Unable to determine', 'Incapaz de determinar']
                               ])

followup_subform_fields = [
  lrf_field('lrf_followup_form_completed_date', 'date_field', 'Form completion date',
            'Fecha cuando se completo el formulario', 'date_validation' => 'not_future_date'),
  lrf_field('lrf_followup_case_reference', 'text_field', 'Case reference number',
            'Numero de referencia del caso'),
  lrf_field('lrf_followup_date', 'date_field', 'Follow-up date', 'Fecha del seguimiento',
            'date_validation' => 'not_future_date'),
  lrf_field('lrf_followup_previous_date', 'date_field', 'Previous follow-up date',
            'Fecha del seguimiento anterior', 'date_validation' => 'not_future_date'),
  lrf_field('lrf_followup_with', 'select_box', 'Follow-up completed with', 'Seguimiento realizado con',
            followup_with.merge('multi_select' => true)),
  lrf_field('lrf_followup_with_other', 'text_field', 'Other person followed up with',
            'Otra persona con quien se hizo seguimiento'),
  lrf_field('lrf_followup_method', 'select_box', 'Follow-up method', 'Metodo de seguimiento',
            followup_methods.merge('multi_select' => true)),
  lrf_field('lrf_followup_method_other', 'text_field', 'Other follow-up method',
            'Otro metodo de seguimiento'),
  lrf_field('lrf_followup_specific_action', 'radio_button',
            'Was this follow-up related to a specific action or assistance?',
            'Fue seguimiento a una accion o asistencia especifica', yes_no),
  lrf_field('lrf_followup_action_details', 'textarea',
            'Action or reunification point followed up',
            'Accion, asistencia o punto de reunificacion al que se dio seguimiento'),
  lrf_field('lrf_followup_purpose', 'textarea', 'Purpose of follow-up', 'Proposito del seguimiento'),
  lrf_field('lrf_followup_conclusion', 'textarea', 'Follow-up conclusion', 'Conclusion del seguimiento'),
  lrf_field('lrf_followup_action_confirmed', 'select_box',
            'Was the action or assistance completed?',
            'Se realizo la accion o asistencia', yes_no_unable),
  lrf_field('lrf_followup_situation_change', 'select_box',
            'Change in the child situation', 'Cambio en la situacion del NNA', situation_change),
  lrf_field('lrf_followup_another_report_required', 'radio_button',
            'Is another follow-up report required?', 'Se requiere otro informe de seguimiento', yes_no),
  lrf_field('lrf_followup_next_date', 'date_field', 'Next follow-up date', 'Fecha del proximo seguimiento'),
  lrf_field('lrf_followup_recommendations', 'textarea',
            'Technical recommendations', 'Recomendaciones tecnicas'),
  lrf_field('lrf_followup_completed_by', 'text_field',
            'Field or regional coordinator completing follow-up',
            'Coordinador de terreno o region que realiza seguimiento')
]

followup_subform = lrf_subform(
  'case_asonacop_lrf_followup_subform', 'case', 111,
  'Nested ASONACOP LRF Follow-up', 'Seguimientos LRF ASONACOP',
  followup_subform_fields, %w[lrf_followup_date lrf_followup_method lrf_followup_another_report_required]
)

lrf_form(
  'case_asonacop_lrf_followup', 'case', 111, 'services_follow_up',
  'ASONACOP LRF Follow-up', 'ASONACOP Seguimiento LRF',
  [
    lrf_field('case_asonacop_lrf_followup_subform', 'subform', 'LRF follow-up records',
              'Registros de seguimiento LRF',
              'subform_section' => followup_subform, 'subform_sort_by' => 'lrf_followup_date')
  ]
)

closure_reasons = lrf_options([
                                ['reunification_objective_achieved', 'Reunification objective achieved',
                                 'Se logro el objetivo principal de reunificacion familiar'],
                                ['turned_18', 'Child turned 18 with transition plan',
                                 'El NNA cumplio la mayoria de edad con plan de transicion'],
                                ['assistance_declined', 'Child or caregiver declined further assistance',
                                 'NNA o cuidador no desea mas asistencia'],
                                ['moved_no_service_available', 'Moved to place without protection service',
                                 'Cambio de residencia a lugar sin servicio de proteccion'],
                                ['durable_solution_no_transfer', 'Durable solution where no transfer is possible',
                                 'Solucion duradera sin institucion para transferencia'],
                                ['lost_contact', 'Lost contact for at least three months',
                                 'Se perdio contacto por al menos tres meses'],
                                ['death_of_child', 'Death of child', 'Fallecimiento del NNA'],
                                ['no_further_action_required', 'No further action possible or required',
                                 'No es posible o no se requiere accion adicional'],
                                %w[other Other Otra]
                              ])
closure_care_arrangements = lrf_options([
                                          ['mother_father_or_both', 'Mother, father or both',
                                           'Padre, madre o ambos'],
                                          ['extended_family', 'Relatives / extended family',
                                           'Parientes o familia ampliada'],
                                          ['third_persons', 'Third persons', 'Terceras personas'],
                                          ['adult_sibling', 'Adult sibling', 'Hermano/a mayor de edad'],
                                          ['shelter_protection_measure', 'Shelter protection measure',
                                           'Medida de proteccion de abrigo'],
                                          ['family_placement_or_care_entity', 'Family placement or care entity',
                                           'Colocacion familiar o entidad de atencion'],
                                          %w[other Other Otra]
                                        ])
file_storage_methods = lrf_options([
                                     %w[electronic Electronic Electronicamente],
                                     ['paper_copy', 'Paper copy', 'Copia impresa'],
                                     %w[both Both Ambos]
                                   ])

closure_fields = [
  lrf_field('lrf_closure_form_completed_date', 'date_field', 'Closure form completion date',
            'Fecha cuando se completo el cierre', 'date_validation' => 'not_future_date'),
  lrf_field('lrf_closure_case_reference', 'text_field', 'Case reference number',
            'Numero de referencia del caso'),
  lrf_field('lrf_closure_reason', 'select_box', 'Main closure reason',
            'Razon principal para cerrar el caso', closure_reasons),
  lrf_field('lrf_closure_reason_other', 'textarea', 'If other, specify', 'Si es otra razon, especificar'),
  lrf_field('lrf_closure_weeks_open', 'numeric_field', 'Weeks case was open',
            'Tiempo que lleva abierto el caso en semanas'),
  lrf_field('lrf_closure_current_situation_summary', 'textarea',
            'Current case situation summary', 'Breve resumen de la situacion actual del caso'),
  lrf_field('lrf_closure_child_changed_residence', 'radio_button',
            'Did the child change residence with family or substitute caregiver?',
            'El NNA cambio de residencia con familia de origen o sustituta', yes_no),
  lrf_field('lrf_closure_future_residence', 'textarea',
            'Future habitual residence or localization details',
            'Residencia habitual o lugar donde localizar al NNA'),
  lrf_field('lrf_closure_contact_details', 'textarea',
            'Phone number or other contact modes', 'Telefono u otros modos de contacto'),
  lrf_field('lrf_closure_care_arrangement', 'select_box',
            'Care arrangement at closure', 'Modalidad de cuidado al cierre',
            closure_care_arrangements),
  lrf_field('lrf_closure_care_arrangement_other', 'text_field',
            'Other care arrangement', 'Otra modalidad de cuidado'),
  lrf_field('lrf_closure_permanent_care', 'radio_button',
            'Is this a permanent care arrangement?', 'Es una modalidad de cuidado permanente', yes_no),
  lrf_field('lrf_closure_permanent_care_explanation', 'textarea',
            'If no, explain why', 'Si no, explicar por que'),
  lrf_field('lrf_closure_caregiver_first_names', 'text_field', 'Caregiver first names',
            'Nombres de la persona cuidadora'),
  lrf_field('lrf_closure_caregiver_last_names', 'text_field', 'Caregiver last names',
            'Apellidos de la persona cuidadora'),
  lrf_field('lrf_closure_caregiver_relationship', 'select_box',
            'Relationship with the child', 'Relacion con el NNA',
            'option_strings_source' => 'lookup lookup-family-relationship'),
  lrf_field('lrf_closure_caregiver_residence', 'textarea',
            'Caregiver residence or location', 'Residencia o ubicacion de la persona cuidadora'),
  lrf_field('lrf_closure_process_description', 'textarea',
            'Closure process description', 'Proceso seguido para cerrar el caso'),
  lrf_field('lrf_closure_child_consulted', 'radio_button',
            'Was the child consulted and agrees with closure?',
            'Se consulto al NNA y esta de acuerdo con el cierre', yes_no),
  lrf_field('lrf_closure_child_consulted_reason', 'textarea',
            'If no, explain child consultation issue', 'Si no, indicar motivo respecto al NNA'),
  lrf_field('lrf_closure_caregiver_consulted', 'radio_button',
            'Were caregivers consulted and agree with closure?',
            'Se consulto al cuidador y esta de acuerdo con el cierre', yes_no),
  lrf_field('lrf_closure_caregiver_consulted_reason', 'textarea',
            'If no, explain caregiver consultation issue', 'Si no, indicar motivo respecto al cuidador'),
  lrf_field('lrf_closure_child_feedback_completed', 'radio_button',
            'Was the child feedback form completed?', 'Se completo retroalimentacion del NNA', yes_no),
  lrf_field('lrf_closure_caregiver_feedback_completed', 'radio_button',
            'Was the caregiver feedback form completed?', 'Se completo retroalimentacion del cuidador', yes_no),
  lrf_field('lrf_closure_final_followup_planned', 'radio_button',
            'Is a final three-month follow-up planned?',
            'Se planea ultimo seguimiento en tres meses', yes_no),
  lrf_field('lrf_closure_case_file_updated', 'radio_button',
            'Was the case file updated with all required documents?',
            'Ficha del caso actualizada con documentos necesarios', yes_no),
  lrf_field('lrf_closure_file_storage_method', 'select_box',
            'How will the case file be stored?', 'Como se guardara la ficha del caso',
            file_storage_methods),
  lrf_field('lrf_closure_file_retention_until', 'date_field',
            'Case file retention until', 'Hasta cuando se guardara la ficha del caso'),
  lrf_field('lrf_closure_contact_information_given', 'radio_button',
            'Was the child told who to contact for questions or assistance?',
            'Se comunico al NNA a quien contactar si necesita asistencia', yes_no),
  lrf_field('lrf_closure_contact_person_details', 'textarea',
            'Contact person details given to the child',
            'Datos de contacto indicados al NNA'),
  lrf_field('lrf_closure_completed_by', 'text_field',
            'Field or regional coordinator completing closure',
            'Coordinador de terreno o region que realiza el cierre'),
  lrf_field('lrf_closure_supporting_documents', 'document_upload_box',
            'Closure supporting documents', 'Documentos soporte del cierre')
]

lrf_form(
  'case_asonacop_lrf_closure', 'case', 112, 'closure',
  'ASONACOP LRF Closure', 'ASONACOP Cierre LRF',
  closure_fields, display_help_text_view: true
)

cp_module = PrimeroModule.cp
asonacop_lrf_forms = FormSection.where(
  unique_id: %w[
    tracing_request_asonacop_registration_referral
    case_asonacop_lrf_followup
    case_asonacop_lrf_followup_subform
    case_asonacop_lrf_closure
  ]
)
cp_module.update!(form_sections: cp_module.form_sections | asonacop_lrf_forms)
