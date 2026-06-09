# frozen_string_literal: true

# Copyright (c) 2014 - 2023 UNICEF. All rights reserved.

# To generate the UUID, run the following in the rails consle:
#    SecureRandom.uuid.to_s.gsub('-','')
# TODO module_id: It will be numeric after module model migration

default_case_filters = [
  { 'attribute' => 'status', 'value' => [Record::STATUS_OPEN] },
  { 'attribute' => 'record_state', 'value' => ['true'] }
]

Report.where(editable: false).destroy_all

Report.create({
                name_all: 'Registration CP',
                name_es: 'Registro CP',
                description_all: 'Case registrations over time',
                description_es: 'Registros de casos a lo largo del tiempo',
                module_id: PrimeroModule::CP,
                record_type: 'case',
                aggregate_by: ['registration_date'],
                group_dates_by: 'month',
                filters: default_case_filters,
                is_graph: true,
                editable: false
              })

# TODO: This doesn't account for referrals
Report.create({
                name_all: 'Caseload Summary CP',
                name_es: 'Resumen de carga de casos CP',
                description_all: 'Number of cases for each case worker',
                description_es: 'Número de casos por cada trabajador(a) de casos',
                module_id: PrimeroModule::CP,
                record_type: 'case',
                aggregate_by: ['owned_by'],
                filters: default_case_filters,
                is_graph: true,
                editable: false
              })

Report.create({
                name_all: 'Case status by case worker CP',
                name_es: 'Estado de casos por trabajador(a) CP',
                description_all: 'Status of cases held by case workers',
                description_es: 'Estado de los casos asignados a trabajadores(as) de casos',
                module_id: PrimeroModule::CP,
                record_type: 'case',
                aggregate_by: ['owned_by'],
                disaggregate_by: ['status'],
                filters: [{ 'attribute' => 'record_state', 'value' => ['true'] }],
                is_graph: true,
                editable: false
              })

Report.create({
                name_all: 'Cases by Agency CP',
                name_es: 'Casos por agencia CP',
                description_all: 'Number of cases broken down by agency',
                description_es: 'Número de casos desglosados por agencia',
                module_id: PrimeroModule::CP,
                record_type: 'case',
                aggregate_by: ['owned_by_agency_id'],
                filters: default_case_filters,
                is_graph: true,
                editable: false
              })

Report.create({
                name_all: 'Cases by Nationality',
                name_es: 'Casos por nacionalidad',
                description_all: 'Number of cases broken down by nationality',
                description_es: 'Número de casos desglosados por nacionalidad',
                module_id: PrimeroModule::CP,
                record_type: 'case',
                aggregate_by: ['nationality'],
                filters: default_case_filters,
                is_graph: true,
                editable: false
              })

Report.create({
                name_all: 'Cases by Age and Sex',
                name_es: 'Casos por edad y sexo',
                description_all: 'Number of cases broken down by age and sex',
                description_es: 'Número de casos desglosados por edad y sexo',
                module_id: PrimeroModule::CP,
                record_type: 'case',
                aggregate_by: ['age'],
                disaggregate_by: ['sex'],
                group_ages: true,
                filters: default_case_filters,
                is_graph: true,
                editable: false
              })

Report.create({
                name_all: 'Cases by Protection Concern',
                name_es: 'Casos por riesgo de protección',
                description_all: 'Number of cases broken down by protection concern and sex',
                description_es: 'Número de casos desglosados por riesgo de protección y sexo',
                module_id: PrimeroModule::CP,
                record_type: 'case',
                aggregate_by: ['protection_concerns'],
                disaggregate_by: ['sex'],
                filters: default_case_filters,
                is_graph: true,
                editable: false
              })

Report.create({
                name_all: 'Current Care Arrangements',
                name_es: 'Acuerdos de cuidado actuales',
                description_all: 'The care arrangements broken down by age and sex',
                description_es: 'Acuerdos de cuidado desglosados por edad y sexo',
                module_id: PrimeroModule::CP,
                record_type: 'case',
                aggregate_by: ['care_arrangements_type'],
                disaggregate_by: %w[sex age],
                group_ages: true,
                filters: default_case_filters,
                is_graph: true,
                editable: false
              })

Report.create({
                name_all: 'Workflow Status',
                name_es: 'Estado del flujo de trabajo',
                description_all: 'Cases broken down by current workflow status',
                description_es: 'Casos desglosados por estado actual del flujo de trabajo',
                module_id: PrimeroModule::CP,
                record_type: 'case',
                aggregate_by: ['workflow_status'],
                group_ages: true,
                filters: default_case_filters,
                is_graph: true,
                editable: false
              })

Report.create(
  name_all: 'Follow up by month by Agency',
  name_es: 'Seguimiento por mes y agencia',
  description_all: 'Number of followups broken down by month and agency',
  description_es: 'Número de seguimientos desglosados por mes y agencia',
  module_id: PrimeroModule::CP,
  record_type: 'reportable_follow_up',
  aggregate_by: ['followup_date'],
  disaggregate_by: ['owned_by_agency_id'],
  filters: [
    {
      "attribute": 'status',
      "value": [
        'open'
      ]
    },
    {
      "attribute": 'record_state',
      "value": [
        'true'
      ]
    },
    {
      "attribute": 'followup_date',
      "constraint": 'not_null',
      "value": ''
    }
  ],
  group_ages: false,
  group_dates_by: 'month',
  is_graph: true,
  editable: false
)

Report.create(
  name_all: 'Follow up by week by Agency',
  name_es: 'Seguimiento por semana y agencia',
  description_all: 'Number of followups broken down by week and agency',
  description_es: 'Número de seguimientos desglosados por semana y agencia',
  module_id: PrimeroModule::CP,
  record_type: 'reportable_follow_up',
  aggregate_by: ['followup_date'],
  disaggregate_by: ['owned_by_agency_id'],
  filters: [
    {
      "attribute": 'status',
      "value": [
        'open'
      ]
    },
    {
      "attribute": 'record_state',
      "value": [
        'true'
      ]
    },
    {
      "attribute": 'followup_date',
      "constraint": 'not_null',
      "value": ''
    }
  ],
  group_ages: false,
  group_dates_by: 'week',
  is_graph: true,
  editable: false
)

Report.create(
  name_all: 'Cases per Month',
  name_es: 'Casos por mes',
  description_all: ' Number of newly registered cases per month per location ',
  description_es: 'Número de casos nuevos registrados por mes y ubicación',
  module_id: PrimeroModule::CP,
  record_type: 'case',
  aggregate_by: ['owned_by_location'],
  disaggregate_by: ['created_at'],
  filters: [{ 'attribute' => 'record_state', 'value' => ['true'] }],
  group_ages: false,
  group_dates_by: 'month',
  is_graph: true,
  editable: false
)

Report.create({
                name_all: 'Cases with case plans',
                name_es: 'Casos con planes de caso',
                description_all: 'How many registered cases have case plans?',
                description_es: 'Cantidad de casos registrados que tienen planes de caso',
                module_id: PrimeroModule::CP,
                record_type: 'case',
                aggregate_by: ['has_case_plan'],
                group_ages: false,
                group_dates_by: 'date',
                filters: default_case_filters,
                is_graph: false,
                editable: false
              })
