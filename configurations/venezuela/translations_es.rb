# frozen_string_literal: true

# Spanish labels for the database-backed CP case configuration. Locale YAML
# files do not cover forms, fields, or lookup values stored in the database.
require 'twitter_cldr'

puts 'Loading Spanish CP case translations'

def update_localized_property(record, property, translation)
  values = record.public_send("#{property}_i18n") || {}
  record.update!("#{property}_i18n" => values.merge('es' => translation))
end

def update_lookup_es(unique_id, name:, values:)
  lookup = Lookup.find_by!(unique_id:)
  update_localized_property(lookup, :name, name)
  lookup.update_translations(:es, 'lookup_values' => values)
  lookup.save!
end

SECTION_NAMES_ES = {
  'Record Owner' => 'Responsable del registro',
  'CP Record Owner' => 'Responsable del registro',
  'Inquirer' => 'Solicitante',
  'Tracing Request' => 'Solicitud de localización',
  'CP Incident' => 'Incidente CP',
  'Record Information' => 'Información del registro',
  'Incident Details' => 'Detalles del incidente',
  'Perpetrator Details' => 'Detalles del presunto responsable',
  'CP Individual Details' => 'Detalles de la persona',
  'Summary' => 'Resumen',
  'Approvals' => 'Aprobaciones',
  'Registry Details' => 'Detalles del registro',
  'Incidents' => 'Incidentes',
  'Family Details' => 'Detalles de la familia',
  'Referral' => 'Derivación',
  'Transfer and Assignments' => 'Transferencias y asignaciones',
  'Change Log' => 'Historial de cambios',
  'BID Records' => 'Registros BID',
  'Care Arrangements' => 'Acuerdos de cuidado',
  'Referrals and Transfers' => 'Derivaciones y transferencias',
  'Case Reopened' => 'Caso reabierto',
  'Photos and Audio' => 'Fotos y audio',
  "Nested Child's Preferences" => 'Preferencias del niño',
  "Child's Wishes" => 'Deseos del niño',
  'Assessment' => 'Evaluación',
  'Data Confidentiality' => 'Confidencialidad de los datos',
  'Nested Transitions Subform' => 'Transiciones',
  'Nested Care Arrangements' => 'Acuerdos de cuidado',
  'Nested Family Details' => 'Detalles de la familia',
  'Basic Identity' => 'Identidad básica',
  'Other Documents' => 'Otros documentos',
  'Follow Up' => 'Seguimiento',
  'Tracing' => 'Localización',
  'Protection Concerns' => 'Riesgos de protección',
  'Notes' => 'Notas',
  'Nested Tracing Action' => 'Acciones de localización',
  'Nested Notes Subform' => 'Notas',
  'Nested Incident Details Subform' => 'Detalles del incidente',
  'Nested Followup Subform' => 'Seguimiento',
  'Closure' => 'Cierre',
  'Family Consent' => 'Consentimiento familiar',
  'Family Members' => 'Miembros de la familia',
  'Nested Family Members' => 'Miembros de la familia',
  'Family Overview' => 'Resumen de familia',
  'Family Notes' => 'Notas familiares',
  'Documents' => 'Documentos',
  'Services' => 'Servicios',
  'Nested Services' => 'Servicios',
  'Nested Protection Concerns Subform' => 'Riesgos de protección',
  'Protection Concern Details' => 'Detalles de riesgos de protección',
  'Other Identity Details' => 'Otros datos de identidad',
  'Case Plan' => 'Plan del caso',
  'Other Reportable Fields' => 'Otros campos de reporte',
  'List of Interventions and Services' => 'Lista de intervenciones y servicios'
}.freeze

FIELD_LABELS_ES = {
  'Long ID' => 'ID largo',
  'Short ID' => 'ID corto',
  'Case ID' => 'ID del caso',
  'CPIMS ID' => 'ID de CPIMS',
  'Marked for offline?' => '¿Marcado para uso sin conexión?',
  'Case Status' => 'Estado del caso',
  'Case Reopened?' => '¿Caso reabierto?',
  'Full Name' => 'Nombre completo',
  'First Name' => 'Nombre',
  'Middle Name' => 'Segundo nombre',
  'Surname' => 'Apellido',
  'Nickname' => 'Apodo',
  'Other Name' => 'Otro nombre',
  'Date of Registration or Interview' => 'Fecha de registro o entrevista',
  'Date Assessment Due' => 'Fecha límite de evaluación',
  'Sex' => 'Sexo',
  'Age' => 'Edad',
  'Date of Birth' => 'Fecha de nacimiento',
  'Is the age estimated?' => '¿La edad es estimada?',
  'National ID Number' => 'Número de identificación nacional',
  'Type of Other ID Document' => 'Tipo de otro documento de identidad',
  'Number of Other ID Document' => 'Número de otro documento de identidad',
  'Other Agency ID' => 'ID de otra agencia',
  'Other Agency Name' => 'Nombre de otra agencia',
  'Nationality' => 'Nacionalidad',
  'Current Civil/Marital Status' => 'Estado civil actual',
  'Occupation' => 'Ocupación',
  'Current Address' => 'Dirección actual',
  'Current Location' => 'Ubicación actual',
  'Is this address permanent?' => '¿Esta dirección es permanente?',
  'Current Telephone' => 'Teléfono actual',
  'Protection Status' => 'Estado de protección',
  'Urgent Protection Concern?' => '¿Riesgo de protección urgente?',
  'Risk Level' => 'Nivel de riesgo',
  'Displacement Status' => 'Estado de desplazamiento',
  'Protection Concerns' => 'Riesgos de protección',
  'If Other, please specify' => 'Si es otro, especifique',
  'UNHCR Needs Codes' => 'Códigos de necesidades de ACNUR',
  'Disability Type' => 'Tipo de discapacidad',
  'Country of Origin' => 'País de origen',
  'Last Address' => 'Última dirección',
  'Last Location' => 'Última ubicación',
  'Last Telephone' => 'Último teléfono',
  'Ethnicity/Clan/Tribe' => 'Etnia, clan o tribu',
  'Sub Ethnicity 1' => 'Subetnia 1',
  'Sub Ethnicity 2' => 'Subetnia 2',
  'Language' => 'Idioma',
  'Religion' => 'Religión',
  'Consent Obtained From' => 'Consentimiento obtenido de',
  'Consent has been obtained for the child to receive case management services' =>
    'Se obtuvo consentimiento para que el niño reciba servicios de gestión de casos',
  'Consent is given share non-identifiable information for reporting' =>
    'Se autoriza compartir información no identificable para reportes',
  'The individual providing consent agrees to share collected information with other organizations for service provision?' =>
    '¿La persona que da el consentimiento acepta compartir información con otras organizaciones para prestar servicios?',
  'Consent Details for Sharing Information' => 'Detalles del consentimiento para compartir información',
  'What information should be withheld from a particular person or individual' =>
    '¿Qué información debe restringirse a una persona específica?',
  'Reason for withholding information' => 'Motivo para restringir información',
  'If other reason for withholding information, please specify' => 'Si existe otro motivo, especifique',
  'Approved by Manager' => 'Aprobado por el responsable',
  'Date' => 'Fecha',
  'Manager Comments' => 'Comentarios del responsable',
  'Approval Status' => 'Estado de aprobación',
  'Assessment started on' => 'Evaluación iniciada el',
  'Date Case Plan Due' => 'Fecha límite del plan del caso',
  'Approval Type' => 'Tipo de aprobación',
  'Date Case Plan Initiated' => 'Fecha de inicio del plan del caso',
  'Intervention Plans and Services to be Provided' => 'Planes de intervención y servicios por proporcionar',
  'Intervention plans and services details' => 'Detalles de planes de intervención y servicios',
  'Current Care Arrangement' => 'Acuerdo de cuidado actual',
  'Name of Current Caregiver' => 'Nombre del cuidador actual',
  "What are the child's current care arrangements?" => '¿Cuáles son los acuerdos de cuidado actuales del niño?',
  'When did this care arrangement start?' => '¿Cuándo comenzó este acuerdo de cuidado?',
  "What is the reason for closing the child's file?" => '¿Cuál es el motivo para cerrar el expediente del niño?',
  'If other, please specify' => 'Si es otro, especifique',
  'Date of Closure' => 'Fecha de cierre',
  'Photos' => 'Fotos',
  'Recorded Audio' => 'Audio grabado',
  'Other Document' => 'Otro documento',
  'Valid Record?' => '¿Registro válido?',
  "Record Owner's Agency" => 'Agencia responsable del registro',
  "Record Owner's Location" => 'Ubicación responsable del registro',
  'Does this case have a case plan?' => '¿Este caso tiene un plan?',
  'Workflow Status' => 'Estado del flujo de trabajo',
  'Record Status' => 'Estado del registro',
  'Registration Date' => 'Fecha de registro',
  'Family ID' => 'ID de familia',
  'Family Type' => 'Tipo de familia',
  'Family Name' => 'Nombre de la familia',
  'Family Number' => 'Número de familia',
  'Family Address' => 'Dirección de la familia',
  'Family Landmark' => 'Punto de referencia de la familia',
  'Family Location' => 'Ubicación de la familia',
  'Family Telephone' => 'Teléfono de la familia',
  'Languages spoken' => 'Idiomas hablados',
  'Size of Family' => 'Tamaño de la familia',
  'Notes on Family' => 'Notas sobre la familia',
  'Additional Notes on the family' => 'Notas adicionales sobre la familia',
  'Family Member' => 'Miembro de la familia',
  'Primary reason for family closure' => 'Motivo principal del cierre familiar',
  'Provide further details on reason for family closure' => 'Proporcione más detalles sobre el motivo del cierre familiar',
  'Reasons for collecting and retaining information on this Family' =>
    'Motivos para recopilar y conservar información sobre esta familia',
  'Provide the name of the individual who provided the consent' =>
    'Indique el nombre de la persona que dio el consentimiento',
  'Reason for updating consent' => 'Motivo para actualizar el consentimiento',
  'Consent has been given for the family to participate in the case management process' =>
    'Se otorgó consentimiento para que la familia participe en el proceso de gestión del caso',
  'Consent has been given to the caseworker assigned to the case to collect and store personal information about the case (e.g., name, photo, family details).' =>
    'Se otorgó consentimiento para que el trabajador asignado recopile y almacene información personal del caso, por ejemplo nombre, fotografía y datos familiares.',
  'The individual providing consent agrees to share information about this case with other service providers according to the details described below.' =>
    'La persona que otorga el consentimiento acepta compartir información de este caso con otros proveedores de servicios según los detalles indicados abajo.',
  'Information can be shared for the following services' =>
    'La información puede compartirse para los siguientes servicios',
  'The individual providing consent agrees to share information about this case with UNHCR for the purposes of refugee protection case management.' =>
    'La persona que otorga el consentimiento acepta compartir información de este caso con ACNUR para la gestión de casos de protección de refugiados.',
  'Consent has been given to share the information collected with' =>
    'Se otorgó consentimiento para compartir la información recopilada con',
  'If information can be shared with others, please specify who' =>
    'Si la información puede compartirse con otras personas, especifique con quién',
  'Withhold specific information from' => 'Restringir información específica a',
  'What specific information should be withheld' => 'Qué información específica debe restringirse',
  'What is their role in the family?' => 'Cuál es su rol en la familia',
  'Is this person the caregiver for one of the children in this family?' =>
    '¿Esta persona es cuidadora de alguno de los niños de esta familia?',
  'Notes on their role in the family.' => 'Notas sobre su rol en la familia',
  'Additional notes on the family member.' => 'Notas adicionales sobre el miembro de la familia',
  'List any agency identifiers as a comma separated list' =>
    'Liste cualquier identificador de agencia separado por comas',
  'Other names or spellings known by' => 'Otros nombres o formas de escribir el nombre',
  'National ID' => 'Documento nacional de identidad',
  'UNHCR Individual ID' => 'ID individual de ACNUR',
  'Other ID' => 'Otro ID',
  'Ethnicity' => 'Etnia',
  'Current Address (if different from the child)' =>
    'Dirección actual, si es diferente a la del niño',
  'Is this a permanent location?' => '¿Esta ubicación es permanente?',
  'Current Landmark' => 'Punto de referencia actual',
  'Last Known Address' => 'Última dirección conocida',
  'Last Known Location' => 'Última ubicación conocida',
  'Telephone / other contact details' => 'Teléfono u otros datos de contacto',
  'Notes on the Family Location and Telephone' =>
    'Notas sobre la ubicación y el teléfono de la familia',
  'Notes entered by' => 'Notas ingresadas por',
  'Document' => 'Documento',
  'Created at' => 'Creado el',
  'Current Owner' => 'Responsable actual',
  'Field/Case/Social Worker' => 'Trabajador de campo, caso o trabajo social',
  'Caseworker Code' => 'Código del trabajador del caso',
  'Reassigned / Transferred On' => 'Fecha de reasignación o transferencia',
  'Agency' => 'Agencia',
  'Other Assigned Users' => 'Otros usuarios asignados',
  'Record History' => 'Historial del registro',
  'Record created by' => 'Registro creado por',
  'Created by agency' => 'Creado por la agencia',
  'Previous Owner' => 'Responsable anterior',
  'Previous Agency' => 'Agencia anterior',
  'Module' => 'Módulo',
  'Transfer Status' => 'Estado de transferencia',
  'Transfers and Referrals' => 'Transferencias y derivaciones',
  'Matched Tracing Request ID' => 'ID de solicitud de localización coincidente',
  'Separation History' => 'Historial de separación',
  'Tracing Status' => 'Estado de localización',
  'Date of Separation' => 'Fecha de separación',
  'What was the main cause of separation?' => '¿Cuál fue la causa principal de la separación?',
  'Separation Location' => 'Lugar de separación',
  'Incident Details' => 'Detalles del incidente',
  'Family Details' => 'Detalles de la familia',
  'Care Arrangements' => 'Acuerdos de cuidado',
  'Follow Up' => 'Seguimiento',
  'Services' => 'Servicios',
  'Notes' => 'Notas',
  'Protection Concern Details' => 'Detalles de riesgos de protección',
  'Action taken and remarks' => 'Acción realizada y observaciones',
  'Address/Village where the tracing action took place' => 'Dirección o localidad donde se realizó la localización',
  'Appointment Date' => 'Fecha de la cita',
  'Area of the Incident' => 'Área del incidente',
  'BID Document' => 'Documento BID',
  "Caregiver's Age" => 'Edad del cuidador',
  "Caregiver's Date of Birth (DOB)" => 'Fecha de nacimiento del cuidador',
  'Case Plan' => 'Plan del caso',
  'Case Reopened' => 'Caso reabierto',
  "Child's Preferences" => 'Preferencias del niño',
  'Comments' => 'Comentarios',
  'Created on' => 'Creado el',
  'Date Reopened' => 'Fecha de reapertura',
  'Date of Incident' => 'Fecha del incidente',
  'Date of referral or transfer' => 'Fecha de derivación o transferencia',
  'Date of tracing' => 'Fecha de localización',
  'Details of the concern' => 'Detalles del riesgo',
  "Did the case worker have the child's consent to make this transfer?" =>
    '¿El trabajador del caso tenía el consentimiento del niño para realizar esta transferencia?',
  'Does child want to trace family members?' => '¿El niño desea localizar a familiares?',
  'Ethnicity' => 'Etnia',
  'Expected timeframe (end date)' => 'Plazo previsto (fecha de finalización)',
  'Follow up date' => 'Fecha de seguimiento',
  'Follow up needed by' => 'Seguimiento requerido por',
  'Goal of intervention / service' => 'Objetivo de la intervención o servicio',
  'Has the case been previously abused?' => '¿El caso ha sufrido abuso anteriormente?',
  'How are they related to the child?' => '¿Qué relación tienen con el niño?',
  'Identification of Incident' => 'Identificación del incidente',
  "If 'Other', please specify" => 'Si es otro, especifique',
  'If dead, please provide details' => 'Si falleció, proporcione detalles',
  'If not with parents, main person caring for the child.' => 'Si no está con sus padres, persona principal a cargo del niño',
  'If this is a new caregiver, give the reason for the change' => 'Si es un cuidador nuevo, indique el motivo del cambio',
  'If this is the current caregiver, include in the Referral Details form?' =>
    'Si es el cuidador actual, ¿incluirlo en el formulario de detalles de derivación?',
  'If yes please describe in brief' => 'Si la respuesta es sí, describa brevemente',
  'Implementation Timeframe' => 'Plazo de implementación',
  'Implementing Agency' => 'Agencia implementadora',
  'Incident' => 'Incidente',
  'Incident Status' => 'Estado del incidente',
  'Is the referral or transfer to a remote system?' => '¿La derivación o transferencia es hacia un sistema remoto?',
  'Is this family member alive?' => '¿Este familiar está vivo?',
  'Is this person the caregiver?' => '¿Esta persona es el cuidador?',
  'Local User' => 'Usuario local',
  'Location of Tracing' => 'Lugar de localización',
  'Location of the Incident' => 'Lugar del incidente',
  'Manager' => 'Responsable',
  'Name' => 'Nombre',
  'Name of intervention / service to be provided' => 'Nombre de la intervención o servicio por proporcionar',
  'No Consent to Share Setting Overridden' => 'Excepción aplicada a la falta de consentimiento para compartir',
  'Notes on the referral from provider' => 'Notas del proveedor sobre la derivación',
  'Other names or spellings caregiver is known by' => 'Otros nombres o formas de escribir el nombre del cuidador',
  'Other persons well known to the child' => 'Otras personas conocidas por el niño',
  'Outcome of tracing action' => 'Resultado de la acción de localización',
  'Period when identified?' => '¿Período en que fue identificado?',
  'Perpetrator information' => 'Información del responsable',
  'Person / agency providing the service or implementing the intervention / services and contact details' =>
    'Persona o agencia que presta el servicio o implementa la intervención y sus datos de contacto',
  'Person(s) child wishes to locate' => 'Personas que el niño desea localizar',
  'Please specify the actual time of the Incident' => 'Especifique la hora exacta del incidente',
  'Preference of the child to be relocated with this person' => 'Preferencia del niño de ser reubicado con esta persona',
  'Reason rejected (if applicable)' => 'Motivo del rechazo, si corresponde',
  'Referred?' => '¿Derivado?',
  'Relationship to child' => 'Relación con el niño',
  'Relationship with the victim' => 'Relación con la víctima',
  'Relationship with the abused' => 'Relación con la persona afectada',
  'Remote User' => 'Usuario remoto',
  'Remote User Agency' => 'Agencia del usuario remoto',
  'Reopened by' => 'Reabierto por',
  'Service' => 'Servicio',
  'Service Implemented On' => 'Fecha de implementación del servicio',
  'Service Location' => 'Lugar del servicio',
  'Service Provider' => 'Proveedor del servicio',
  'Service delivery location' => 'Lugar de prestación del servicio',
  'Service implemented' => 'Servicio implementado',
  'Service provider name' => 'Nombre del proveedor del servicio',
  'Educational Status' => 'Nivel educativo',
  'Social Status' => 'Estado social',
  'Status' => 'Estado',
  'Subject' => 'Asunto',
  'Successfully implemented?' => '¿Implementado correctamente?',
  'Telephone' => 'Teléfono',
  'Time of Incident' => 'Hora del incidente',
  'Transferred or Referred By' => 'Transferido o derivado por',
  'Type' => 'Tipo',
  'Type of Protection Concern' => 'Tipo de riesgo de protección',
  'Type of Response' => 'Tipo de respuesta',
  'Type of Service' => 'Tipo de servicio',
  'Type of Violence' => 'Tipo de violencia',
  'Type of action taken' => 'Tipo de acción realizada',
  'Type of assessment' => 'Tipo de evaluación',
  'Type of follow up' => 'Tipo de seguimiento',
  'Type of service' => 'Tipo de servicio',
  "What is this person's relationship to the child?" => '¿Cuál es la relación de esta persona con el niño?',
  'What type of export do you want' => '¿Qué tipo de exportación desea?'
}.freeze

HELP_TEXT_ES = {
  'Legacy CPIMS (or other system) ID' => 'ID del CPIMS anterior u otro sistema',
  'This includes consent for sharing information with other organizations providing services' =>
    'Incluye el consentimiento para compartir información con otras organizaciones que prestan servicios',
  'This field is used for the Workflow status.' => 'Este campo se utiliza para el estado del flujo de trabajo.',
  'This field is used for the Workflow status' => 'Este campo se utiliza para el estado del flujo de trabajo.',
  'Only PNG, JPEG, and GIF files permitted' => 'Solo se permiten archivos PNG, JPEG y GIF',
  'Only MP3 and M4A files permitted' => 'Solo se permiten archivos MP3 y M4A',
  'Only PDF, TXT, DOC, DOCX, XLS, XLSX, CSV, JPG, JPEG, PNG files permitted' =>
    'Solo se permiten archivos PDF, TXT, DOC, DOCX, XLS, XLSX, CSV, JPG, JPEG y PNG',
  'Enter the Implementation Timeframe for the service; the timeframe is used in the dashboard to indicate if services are overdue.' =>
    'Indique el plazo de implementación del servicio; se utiliza en el panel para mostrar si está vencido.',
  'Only include if the person being referred is a child' => 'Incluir solo si la persona derivada es un niño',
  'e.g., nickname, second family name' => 'Por ejemplo, apodo o segundo apellido',
  'Date the Family record was created.' => 'Fecha en que se creó el registro de la familia.',
  'You only need to complete this field if you are changing an entry you made previously.' =>
    'Solo debe completar este campo si está cambiando una entrada que hizo anteriormente.',
  'If consent has not been provided, do not select' =>
    'Si no se ha otorgado consentimiento, no seleccione esta opción.',
  'This includes sharing information with other organizations providing services, this does not include sharing information with UNHCR.' =>
    'Esto incluye compartir información con otras organizaciones proveedoras de servicios; no incluye compartir información con ACNUR.',
  'This field can be copied to/from the Case but is not a shared field and can be edited on the Family record.' =>
    'Este campo puede copiarse desde o hacia el caso, pero no es un campo compartido y puede editarse en el registro de familia.',
  'This field is not shared with the case records.' =>
    'Este campo no se comparte con los registros de caso.',
  'Include date of death if known ' => 'Incluya la fecha de fallecimiento si se conoce.',
  'If separated from child, last known address' =>
    'Si está separado del niño, última dirección conocida.',
  'Additional notes on the family not shared with the associated case records.' =>
    'Notas adicionales sobre la familia que no se comparten con los casos asociados.',
  'Note here if the family has multiple addresses and / or multiple telephone numbers that should be used.' =>
    'Indique aquí si la familia tiene varias direcciones o varios teléfonos que deban utilizarse.'
}.freeze

FORM_GROUPS_ES = {
  'record_information' => 'Información del registro',
  'approvals' => 'Aprobaciones',
  'case_conference_details' => 'Detalles de la conferencia del caso',
  'identification_registration' => 'Identificación y registro',
  'data_confidentiality' => 'Confidencialidad de los datos',
  'assessment' => 'Evaluación',
  'family_partner_details' => 'Detalles de la familia o pareja',
  'case_plan' => 'Plan del caso',
  'services_follow_up' => 'Servicios y seguimiento',
  'closure' => 'Cierre',
  'tracing' => 'Localización',
  'bia_form' => 'Formulario BIA',
  'photos_audio' => 'Fotos y audio',
  'other_documents' => 'Otros documentos',
  'referrals_transfers' => 'Derivaciones y transferencias',
  'notes' => 'Notas',
  'documents' => 'Documentos',
  'other_reportable_fields' => 'Otros campos de reporte'
}.freeze

FormSection.where(parent_form: %w[case tracing_request incident family]).find_each do |section|
  section_name = SECTION_NAMES_ES[section.name_en]
  update_localized_property(section, :name, section_name) if section_name

  section.fields.each do |field|
    field_name = FIELD_LABELS_ES[field.display_name_en]
    update_localized_property(field, :display_name, field_name) if field_name

    help_text = HELP_TEXT_ES[field.help_text_en]
    update_localized_property(field, :help_text, help_text) if help_text

    update_localized_property(field, :tick_box_label, 'Sí') if field.tick_box_label_en == 'Yes'
  end
end

update_lookup_es(
  'lookup-form-group-cp-case',
  name: 'Grupos de formularios - Casos CP',
  values: FORM_GROUPS_ES
)
update_lookup_es(
  'lookup-case-status',
  name: 'Estado del caso',
  values: {
    'open' => 'Abierto',
    'closed' => 'Cerrado',
    'transferred' => 'Transferido',
    'duplicate' => 'Duplicado'
  }
)
update_lookup_es(
  'lookup-gender',
  name: 'Sexo',
  values: { 'male' => 'Masculino', 'female' => 'Femenino' }
)
update_lookup_es(
  'lookup-marital-status',
  name: 'Estado civil',
  values: {
    'single' => 'Soltero',
    'married_cohabitating' => 'Casado o en convivencia',
    'divorced_separated' => 'Divorciado o separado',
    'widowed' => 'Viudo'
  }
)
update_lookup_es(
  'lookup-yes-no',
  name: 'Sí o no',
  values: { 'true' => 'Sí', 'false' => 'No' }
)
update_lookup_es(
  'lookup-risk-level',
  name: 'Nivel de riesgo',
  values: { 'high' => 'Alto', 'medium' => 'Medio', 'low' => 'Bajo' }
)
update_lookup_es(
  'lookup-approval-status',
  name: 'Estado de aprobación',
  values: {
    'requested' => 'Solicitado',
    'pending' => 'Pendiente',
    'approved' => 'Aprobado',
    'rejected' => 'Rechazado'
  }
)
update_lookup_es(
  'lookup-workflow',
  name: 'Flujo de trabajo',
  values: {
    'new' => 'Caso nuevo',
    'closed' => 'Caso cerrado',
    'reopened' => 'Caso reabierto',
    'service_provision' => 'Prestación de servicios',
    'services_implemented' => 'Todos los servicios de respuesta implementados',
    'case_plan' => 'Plan del caso'
  }
)
update_lookup_es(
  'lookup-approval-type',
  name: 'Tipo de aprobación',
  values: { 'service_provision' => 'Prestación de servicios' }
)
update_lookup_es(
  'lookup-care-arrangements-type',
  name: 'Tipo de acuerdo de cuidado',
  values: {
    'parent_s' => 'Padres',
    'step_parent' => 'Padrastro o madrastra',
    'customary_caregiver_s' => 'Cuidadores habituales',
    'adult_sibling' => 'Hermano adulto',
    'kinship_care_extended_family' => 'Cuidado por familiares o familia extendida',
    'foster_care' => 'Acogimiento familiar',
    'residential_care' => 'Cuidado residencial',
    'kafala' => 'Kafala',
    'independent_living' => 'Vida independiente',
    'child_headed_household' => 'Hogar encabezado por un niño',
    'unrelated_adult' => 'Adulto sin parentesco',
    'no_care_arrangement' => 'Sin acuerdo de cuidado',
    'other' => 'Otro'
  }
)
update_lookup_es(
  'lookup-caregiver-change-reason',
  name: 'Motivo del cambio de cuidador',
  values: {
    'abuse_exploitation' => 'Abuso o explotación',
    'death_of_caregiver' => 'Fallecimiento del cuidador',
    'Education' => 'Educación',
    'ill_health_of_caregiver' => 'Problemas de salud del cuidador',
    'other' => 'Otro',
    'poverty' => 'Pobreza',
    'relationship_breakdown' => 'Ruptura de la relación'
  }
)
update_lookup_es(
  'lookup-disability-type',
  name: 'Tipo de discapacidad',
  values: {
    'mental_disability' => 'Discapacidad mental',
    'physical_disability' => 'Discapacidad física',
    'both' => 'Ambas'
  }
)
update_lookup_es(
  'lookup-displacement-status',
  name: 'Estado de desplazamiento',
  values: {
    'resident' => 'Residente',
    'idp' => 'Persona desplazada internamente',
    'refugee' => 'Refugiado',
    'stateless_person' => 'Persona apátrida',
    'returnee' => 'Retornado',
    'foreign_national' => 'Extranjero',
    'asylum_seeker' => 'Solicitante de asilo'
  }
)
update_lookup_es(
  'lookup-family-relationship',
  name: 'Relación familiar',
  values: {
    'mother' => 'Madre',
    'father' => 'Padre',
    'aunt' => 'Tía',
    'uncle' => 'Tío',
    'grandmother' => 'Abuela',
    'grandfather' => 'Abuelo',
    'brother' => 'Hermano',
    'sister' => 'Hermana',
    'husband' => 'Esposo',
    'wife' => 'Esposa',
    'partner' => 'Pareja',
    'other_family' => 'Otro familiar',
    'other_nonfamily' => 'Otra persona sin parentesco'
  }
)
update_lookup_es(
  'lookup-followup-type',
  name: 'Tipo de seguimiento',
  values: {
    'after_reunification' => 'Seguimiento después de la reunificación',
    'in_care' => 'Seguimiento durante el cuidado',
    'for_service' => 'Seguimiento del servicio',
    'for_assesment' => 'Seguimiento de la evaluación'
  }
)
update_lookup_es(
  'lookup-protection-status',
  name: 'Estado de protección',
  values: { 'unaccompanied' => 'No acompañado', 'separated' => 'Separado' }
)
update_lookup_es(
  'lookup-protection-concerns',
  name: 'Riesgos de protección',
  values: {
    'sexually_exploited' => 'Explotación sexual',
    'gbv_survivor' => 'Sobreviviente de violencia de género',
    'trafficked_smuggled' => 'Trata o tráfico de personas',
    'statelessness' => 'Apatridia',
    'arrested_detained' => 'Arrestado o detenido',
    'migrant' => 'Migrante',
    'disabled' => 'Con discapacidad',
    'serious_health_issue' => 'Problema grave de salud',
    'refugee' => 'Refugiado',
    'caafag' => 'Niño asociado con fuerzas o grupos armados',
    'street_child' => 'Niño en situación de calle',
    'child_mother' => 'Niña madre',
    'physically_or_mentally_abused' => 'Abuso físico o mental',
    'living_with_vulnerable_person' => 'Convive con una persona vulnerable',
    'worst_forms_of_child_labor' => 'Peores formas de trabajo infantil',
    'child_headed_household' => 'Hogar encabezado por un niño',
    'mentally_distressed' => 'Afectación emocional',
    'other' => 'Otro'
  }
)
update_lookup_es(
  'lookup-separation-cause',
  name: 'Causa de separación',
  values: {
    'conflict' => 'Conflicto',
    'death' => 'Fallecimiento',
    'family_abuse_violence_exploitation' => 'Abuso, violencia o explotación familiar',
    'lack_of_access_to_services_support' => 'Falta de acceso a servicios o apoyo',
    'caafag' => 'Niño asociado con fuerzas o grupos armados',
    'sickness_of_family_member' => 'Enfermedad de un familiar',
    'entrusted_into_the_care_of_an_individual' => 'Confiado al cuidado de otra persona',
    'arrest_and_detention' => 'Arresto y detención',
    'abandonment' => 'Abandono',
    'repatriation' => 'Repatriación',
    'population_movement' => 'Movimiento de población',
    'migration' => 'Migración',
    'poverty' => 'Pobreza',
    'natural_disaster' => 'Desastre natural',
    'divorce_remarriage' => 'Divorcio o nuevo matrimonio',
    'other_please_specify' => 'Otro, especifique'
  }
)
update_lookup_es(
  'lookup-service-implemented',
  name: 'Servicio implementado',
  values: { 'not_implemented' => 'No implementado', 'implemented' => 'Implementado' }
)
update_lookup_es(
  'lookup-service-response-type',
  name: 'Tipo de respuesta del servicio',
  values: {
    'care_plan' => 'Plan de cuidado',
    'action_plan' => 'Plan de acción',
    'service_provision' => 'Prestación de servicios'
  }
)
update_lookup_es(
  'lookup-service-type',
  name: 'Tipo de servicio',
  values: {
    'safehouse_service' => 'Servicio de refugio seguro',
    'health_medical_service' => 'Servicio médico o de salud',
    'psychosocial_service' => 'Servicio psicosocial',
    'police_other_service' => 'Policía u otro servicio',
    'legal_assistance_service' => 'Asistencia legal',
    'livelihoods_service' => 'Medios de vida',
    'child_protection_service' => 'Protección infantil',
    'family_mediation_service' => 'Mediación familiar',
    'family_seunification_service' => 'Reunificación familiar',
    'education_service' => 'Educación',
    'nfi_clothes_shoes_service' => 'Artículos no alimentarios, ropa o calzado',
    'water_sanitation_service' => 'Agua y saneamiento',
    'registration_service' => 'Registro',
    'food_service' => 'Alimentación',
    'other_service' => 'Otro servicio'
  }
)
update_lookup_es(
  'lookup-time-of-day',
  name: 'Momento del día',
  values: { 'morning' => 'Mañana', 'noon' => 'Mediodía', 'evening' => 'Tarde', 'night' => 'Noche' }
)
update_lookup_es(
  'lookup-tracing-status',
  name: 'Estado de localización',
  values: {
    'open' => 'Abierto',
    'tracing_in_progress' => 'Localización en curso',
    'verified' => 'Verificado',
    'reunified' => 'Reunificado',
    'closed' => 'Cerrado'
  }
)
update_lookup_es(
  'lookup-transition-type',
  name: 'Tipo de transición',
  values: {
    'referral' => 'Derivación',
    'reassign' => 'Reasignación',
    'transfer' => 'Transferencia',
    'transfer_request' => 'Solicitud de transferencia'
  }
)
update_lookup_es(
  'lookup-cp-violence-type',
  name: 'Tipo de violencia de protección infantil',
  values: {
    'rape' => 'Violación',
    'sexual_assault' => 'Agresión sexual',
    'physical_assault' => 'Agresión física',
    'forced_marriage' => 'Matrimonio forzado',
    'denial_of_resources_opportunities_or_services' => 'Negación de recursos, oportunidades o servicios',
    'psychological_emotional_abuse' => 'Abuso psicológico o emocional',
    'non-gbv' => 'No relacionado con violencia de género'
  }
)
update_lookup_es(
  'lookup-disability-communication-best-means',
  name: 'Mejor medio de comunicación ante una discapacidad',
  values: {
    'through_parents' => 'A través de los padres',
    'through_sibling' => 'A través de hermanos',
    'through_family_members' => 'A través de familiares',
    'through_teacher' => 'A través del docente',
    'through_aid' => 'A través de apoyo',
    'through_specialized_center' => 'A través de un centro especializado',
    'other' => 'Otro'
  }
)
update_lookup_es(
  'lookup-incident-identification',
  name: 'Identificación del incidente',
  values: {
    'disclosure_complaint_by_the_abused_person_or_family_member' =>
      'Revelación o denuncia de la persona afectada o un familiar',
    'discovered_by_service_provider' => 'Detectado por el proveedor del servicio',
    'report_by_the_institution_providing_the_service_discovery' =>
      'Reporte de la institución que presta el servicio',
    'other' => 'Otro'
  }
)
update_lookup_es(
  'lookup-incident-location',
  name: 'Lugar del incidente',
  values: {
    'home' => 'Hogar',
    'street' => 'Calle',
    'school' => 'Escuela',
    'work_place' => 'Lugar de trabajo',
    'other' => 'Otro'
  }
)
update_lookup_es(
  'lookup-form-group-cp-incident',
  name: 'Grupos de formularios - Incidente CP',
  values: {
    'record_owner' => 'Responsable del registro',
    'perpetrator_details' => 'Detalles del presunto responsable',
    'cp_incident' => 'Detalles del incidente',
    'cp_individual_details' => 'Detalles de la persona',
    'other_reportable_fields' => 'Otros campos de reporte'
  }
)
update_lookup_es(
  'lookup-form-group-cp-registry-record',
  name: 'Grupos de formularios - Ficha de registro',
  values: {
    'record_information' => 'Informacion del registro',
    'registry_details' => 'Detalles de ficha de registro'
  }
)
update_lookup_es(
  'lookup-form-group-cp-family',
  name: 'Grupos de formularios - Registro de familia',
  values: {
    'record_information' => 'Informacion del registro',
    'family_overview' => 'Resumen de familia',
    'family_closure' => 'Cierre de familia',
    'family_consent' => 'Consentimiento familiar',
    'family_members' => 'Miembros de la familia',
    'family_notes' => 'Notas familiares',
    'family_documents' => 'Documentos',
    'other_reportable_fields' => 'Otros campos de reporte'
  }
)
update_lookup_es(
  'lookup-perpetrator-relationship',
  name: 'Relación con el responsable',
  values: {
    'intimate_partner_former_partner' => 'Pareja íntima o expareja',
    'primary_caregiver' => 'Cuidador principal',
    'family_other_than_spouse_or_caregiver' => 'Familiar distinto del cónyuge o cuidador',
    'supervisor_employer' => 'Supervisor o empleador',
    'schoolmate' => 'Compañero de escuela',
    'teacher_school_official' => 'Docente o personal escolar',
    'service_provider' => 'Proveedor del servicio',
    'cotenant_housemate' => 'Inquilino o compañero de vivienda',
    'family_friend_neighbor' => 'Amigo de la familia o vecino',
    'other_refugee_idp_returnee' => 'Otro refugiado, desplazado o retornado',
    'other_resident_community_member' => 'Otro residente o integrante de la comunidad',
    'other' => 'Otro',
    'no_relation' => 'Sin relación',
    'unknown' => 'Desconocido'
  }
)
update_lookup_es(
  'lookup-special-needs',
  name: 'Necesidades especiales',
  values: {
    'physical_muscular_dystrophy' => 'Física: distrofia muscular',
    'physical_multiple_sclerosis' => 'Física: esclerosis múltiple',
    'physical_chronic_asthma' => 'Física: asma crónica',
    'physical_epilepsy' => 'Física: epilepsia',
    'physical_brain_or_spinal_cord_injuries' => 'Física: lesiones cerebrales o de médula espinal',
    'physical_cerebral_palsy' => 'Física: parálisis cerebral',
    'developmental_down_syndrome' => 'Desarrollo: síndrome de Down',
    'developmental_autism' => 'Desarrollo: autismo',
    'developmental_specific_learning_difficulty' => 'Desarrollo: dificultad específica de aprendizaje',
    'developmental_intellectual_disability_id' => 'Desarrollo: discapacidad intelectual',
    'developmental_attention_deficit_hyperactivity_disorder_adhd' =>
      'Desarrollo: trastorno por déficit de atención e hiperactividad',
    'behavioral_emotional_extremely_challenging_behavior' => 'Conductual o emocional: conducta extremadamente desafiante',
    'behavioral_emotional_aggression_or_self_injurious_behavior_acting_out_fighting' =>
      'Conductual o emocional: agresión o conducta autolesiva',
    'behavioral_emotional_withdrawal_not_interacting_socially_with_others_excessive_fear_or_anxiety_oppositional_behavior' =>
      'Conductual o emocional: aislamiento, temor, ansiedad o conducta oposicionista',
    'sensory_impaired_blind' => 'Sensorial: ceguera',
    'sensory_impaired_visually_impaired' => 'Sensorial: discapacidad visual',
    'sensory_impaired_deaf' => 'Sensorial: sordera',
    'sensory_impaired_limited_hearing' => 'Sensorial: audición limitada'
  }
)

[
  [
    'lookup-location-type',
    'Tipo de ubicación',
    {
      'country' => 'País',
      'region' => 'Región',
      'province' => 'Provincia',
      'district' => 'Distrito',
      'governorate' => 'Gobernación',
      'chiefdom' => 'Jefatura',
      'state' => 'Estado',
      'city' => 'Ciudad',
      'county' => 'Condado',
      'camp' => 'Campamento',
      'site' => 'Sitio',
      'village' => 'Aldea',
      'zone' => 'Zona',
      'sub_district' => 'Subdistrito',
      'locality' => 'Localidad',
      'prefecture' => 'Prefectura',
      'sub-prefecture' => 'Subprefectura',
      'commune' => 'Comuna',
      'payam' => 'Payam',
      'departement_fr' => 'Departamento',
      'region_fr' => 'Región',
      'wilaya' => 'Wilaya',
      'division_fr' => 'División',
      'moughataa' => 'Moughataa',
      'sub_division' => 'Subdivisión',
      'other' => 'Otro'
    }
  ],
  [
    'lookup-nationality',
    'Nacionalidad',
    {
      'venezuela' => 'Venezuela',
      'colombia' => 'Colombia',
      'peru' => 'Perú',
      'ecuador' => 'Ecuador',
      'brasil' => 'Brasil',
      'chile' => 'Chile',
      'argentina' => 'Argentina',
      'bolivia' => 'Bolivia',
      'panama' => 'Panamá',
      'republica_dominicana' => 'República Dominicana',
      'cuba' => 'Cuba',
      'haiti' => 'Haití',
      'guyana' => 'Guyana',
      'trinidad_tobago' => 'Trinidad y Tobago',
      'otro' => 'Otro',
      'no_sabe' => 'No sabe',
      'no_responde' => 'No responde'
    }
  ],
  [
    'lookup-conference-case-status',
    'Estado del caso en conferencia',
    {
      'open' => 'El caso permanecerá abierto',
      'closed' => 'El caso se cerrará',
      'transferred' => 'El caso será transferido',
      'other' => 'Otro'
    }
  ],
  [
    'lookup-armed-force-group-type',
    'Tipo de fuerza o grupo armado',
    {
      'national_army' => 'Ejército nacional',
      'security_forces' => 'Fuerzas de seguridad',
      'international_forces' => 'Fuerzas internacionales',
      'police_forces' => 'Fuerzas policiales',
      'para-military_forces' => 'Fuerzas paramilitares',
      'unknown' => 'Desconocido',
      'other' => 'Otro'
    }
  ],
  [
    'lookup-armed-force-group-name',
    'Nombre de fuerza o grupo armado',
    {
      'armed_force_or_group_1' => 'Fuerza o grupo armado 1',
      'armed_force_or_group_2' => 'Fuerza o grupo armado 2',
      'armed_force_or_group_3' => 'Fuerza o grupo armado 3',
      'other_please_specify' => 'Otro, especifique'
    }
  ],
  [
    'lookup-yes-no-unknown',
    'Sí, no o desconocido',
    { 'true' => 'Sí', 'false' => 'No', 'unknown' => 'Desconocido' }
  ],
  [
    'lookup-yes-no-undecided',
    'Sí, no o indeciso',
    { 'true' => 'Sí', 'false' => 'No', 'undecided' => 'Indeciso' }
  ],
  [
    'lookup-yes-no-duration',
    'Sí, no y duración',
    {
      'yes_short_term' => 'Sí, corto plazo',
      'yes_long_term' => 'Sí, largo plazo',
      'no' => 'No'
    }
  ],
  [
    'lookup-gbv-approval-types',
    'Tipo de aprobación para usuarios GBV',
    { 'case_plan' => 'Plan del caso', 'closure' => 'Cierre' }
  ],
  [
    'lookup-service-referred',
    'Servicio referido',
    {
      'referred' => 'Referido',
      'service_provided_by_your_agency' => 'Servicio prestado por su agencia',
      'services_already_received_from_another_agency' => 'Servicios ya recibidos de otra agencia',
      'service_not_applicable' => 'Servicio no aplicable',
      'referral_declined_by_survivor' => 'Derivación rechazada por la persona sobreviviente',
      'service_unavailable' => 'Servicio no disponible'
    }
  ],
  [
    'lookup-marital-status-with-spouse',
    'Estado civil',
    {
      'single' => 'Soltero',
      'married_cohabitating' => 'Casado o en convivencia',
      'divorced_separated' => 'Divorciado o separado',
      'widowed' => 'Viudo',
      'with_spouse' => 'Con pareja o cónyuge'
    }
  ],
  [
    'lookup-age-group-type',
    'Tipo de grupo de edad',
    { 'adult' => 'Adulto', 'minor' => 'Menor de edad', 'unknown' => 'Desconocido' }
  ],
  [
    'lookup-assessment-progress',
    'Progreso de la evaluación',
    { 'n_a' => 'No aplica', 'in_progress' => 'En progreso', 'met' => 'Cumplido' }
  ],
  [
    'lookup-further-action_needed',
    'Acción adicional necesaria',
    {
      'no_further_action_needed' => 'No se requiere acción adicional',
      'ongoing_monitoring' => 'Monitoreo en curso',
      'urgent_intervention' => 'Intervención urgente'
    }
  ],
  [
    'lookup-agency-office',
    'Oficina de la agencia',
    {
      'agency_office_1' => 'Oficina de la agencia 1',
      'agency_office_2' => 'Oficina de la agencia 2',
      'agency_office_3' => 'Oficina de la agencia 3',
      'agency_office_4' => 'Oficina de la agencia 4',
      'agency_office_5' => 'Oficina de la agencia 5'
    }
  ],
  [
    'lookup-registry-status',
    'Estado del registro',
    { 'open' => 'Abierto', 'closed' => 'Cerrado', 'duplicate' => 'Duplicado' }
  ],
  [
    'lookup-registry-category',
    'Categoría del registro',
    {
      'registry_category1' => 'Categoría del registro 1',
      'registry_category2' => 'Categoría del registro 2',
      'registry_category3' => 'Categoría del registro 3'
    }
  ],
  [
    'lookup-family-type',
    'Tipo de familia',
    {
      'family_type1' => 'Tipo de familia 1',
      'family_type2' => 'Tipo de familia 2',
      'family_type3' => 'Tipo de familia 3'
    }
  ],
  [
    'lookup-form-group-cp-tracing-request',
    'Grupos de formularios - Solicitud de localización',
    {
      'record_owner' => 'Responsable del registro',
      'inquirer' => 'Solicitante',
      'tracing_request' => 'Solicitud de localización',
      'photos_audio' => 'Fotos y audio',
      'other_reportable_fields' => 'Otros campos de reporte'
    }
  ]
].each do |unique_id, name, values|
  update_lookup_es(unique_id, name:, values:)
end

update_lookup_es(
  'lookup-language',
  name: 'Idioma',
  values: {
    'espanol' => 'Español',
    'portugues' => 'Portugués',
    'ingles' => 'Inglés',
    'wayuu' => 'Wayuu',
    'warao' => 'Warao',
    'pemon' => 'Pemón',
    'piaroa' => 'Piaroa',
    'yanomami' => 'Yanomami',
    'arabe' => 'Árabe',
    'italiano' => 'Italiano',
    'otro' => 'Otro',
    'no_sabe' => 'No sabe',
    'no_responde' => 'No responde'
  }
)

%w[lookup-ethnicity lookup-religion].each do |unique_id|
  lookup = Lookup.find_by!(unique_id:)
  update_lookup_es(
    unique_id,
    name: lookup.name_i18n['es'] || lookup.name_i18n['en'],
    values: lookup.lookup_values_i18n.to_h { |value| [value['id'], value.dig('display_text', 'es') || value.dig('display_text', 'en')] }
  )
end

unhcr_codes = Lookup.find_by!(unique_id: 'lookup-unhcr-needs-codes')
update_lookup_es(
  'lookup-unhcr-needs-codes',
  name: 'Códigos de necesidades de ACNUR',
  values: unhcr_codes.lookup_values_en.to_h { |value| [value['id'], value['display_text']] }
)

country_overrides = {
  'bolivia' => 'Bolivia',
  'congo' => 'República del Congo',
  'drc' => 'República Democrática del Congo',
  'cote_divoire' => 'Costa de Marfil',
  'iran' => 'Irán',
  'laos' => 'Laos',
  'macedonia' => 'Macedonia del Norte',
  'north_korea' => 'Corea del Norte',
  'palestine' => 'Palestina',
  'south_korea' => 'Corea del Sur',
  'syria' => 'Siria',
  'taiwan' => 'Taiwán',
  'tanzania' => 'Tanzania',
  'uk' => 'Reino Unido',
  'usa' => 'Estados Unidos',
  'vatican' => 'Ciudad del Vaticano',
  'venezuela' => 'Venezuela',
  'vietnam' => 'Vietnam'
}.freeze
country_lookup = Lookup.find_by!(unique_id: 'lookup-country')
country_values_es = country_lookup.lookup_values_en.to_h do |value|
  translation = country_overrides[value['id']] ||
                TwitterCldr::Shared::Territories.translate_territory(value['display_text'], :en, :es) ||
                value['display_text']
  [value['id'], translation]
end
update_lookup_es('lookup-country', name: 'País', values: country_values_es)
