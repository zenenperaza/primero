# frozen_string_literal: true

module VenezuelaLrfRolePermissions
  class << self
    def apply!
      cp_module = PrimeroModule.cp
      form_permissions = build_form_permissions

      {
        administrator: upsert_administrator(cp_module, form_permissions),
        monitor: upsert_monitor(cp_module, form_permissions),
        regional_coordinator: upsert_regional_coordinator(cp_module, form_permissions),
        field_coordinator: upsert_field_coordinator(cp_module, form_permissions),
        manager: upsert_manager(cp_module, form_permissions)
      }
    end

    private

    def permission(resource, actions)
      Permission.new(resource:, actions:)
    end

    def role_attribute(unique_id, attribute, fallback)
      Role.find_by(unique_id:)&.public_send(attribute).presence || fallback
    end

    def form_permissions_for(parent_forms, permission)
      FormSection.where(parent_form: parent_forms).each_with_object({}) do |form_section, permissions|
        permissions[form_section.unique_id] = permission
      end
    end

    def build_form_permissions
      {
        operational_read: form_permissions_for(
          %w[case incident family registry_record tracing_request],
          FormPermission::PERMISSIONS[:read]
        ),
        operational_read_write: form_permissions_for(
          %w[case incident family registry_record tracing_request],
          FormPermission::PERMISSIONS[:read_write]
        ),
        field_read_write: form_permissions_for(
          %w[case incident family tracing_request],
          FormPermission::PERMISSIONS[:read_write]
        )
      }
    end

    def record_read_actions
      [
        Permission::READ,
        Permission::DISPLAY_VIEW_PAGE,
        Permission::VIEW_PHOTO,
        Permission::VIEW_INCIDENT_FROM_CASE,
        Permission::VIEW_FAMILY_RECORD,
        Permission::VIEW_REGISTRY_RECORD,
        Permission::VIEW_CASE_RELATIONSHIPS,
        Permission::FIND_TRACING_MATCH
      ]
    end

    def case_operational_actions
      record_read_actions + [
        Permission::CREATE,
        Permission::WRITE,
        Permission::ENABLE_DISABLE_RECORD,
        Permission::FLAG,
        Permission::FLAG_UPDATE,
        Permission::ADD_NOTE,
        Permission::ASSIGN,
        Permission::ASSIGN_WITHIN_AGENCY,
        Permission::ASSIGN_WITHIN_USER_GROUP,
        Permission::TRANSFER,
        Permission::RECEIVE_TRANSFER,
        Permission::ACCEPT_OR_REJECT_TRANSFER,
        Permission::REQUEST_TRANSFER,
        Permission::REFERRAL,
        Permission::RECEIVE_REFERRAL,
        Permission::REOPEN,
        Permission::CLOSE,
        Permission::CHANGE_LOG,
        Permission::ACCESS_LOG,
        Permission::INCIDENT_FROM_CASE,
        Permission::INCIDENT_DETAILS_FROM_CASE,
        Permission::LINK_FAMILY_RECORD,
        Permission::ADD_REGISTRY_RECORD,
        Permission::UPDATE_CASE_RELATIONSHIPS,
        Permission::EXPORT_LIST_VIEW,
        Permission::EXPORT_CSV,
        Permission::EXPORT_EXCEL,
        Permission::EXPORT_PDF
      ]
    end

    def case_field_actions
      record_read_actions + [
        Permission::CREATE,
        Permission::WRITE,
        Permission::FLAG,
        Permission::FLAG_UPDATE,
        Permission::ADD_NOTE,
        Permission::REQUEST_APPROVAL_ASSESSMENT,
        Permission::REQUEST_APPROVAL_CASE_PLAN,
        Permission::REQUEST_APPROVAL_ACTION_PLAN,
        Permission::REQUEST_APPROVAL_CLOSURE,
        Permission::INCIDENT_FROM_CASE,
        Permission::INCIDENT_DETAILS_FROM_CASE,
        Permission::LINK_FAMILY_RECORD,
        Permission::UPDATE_CASE_RELATIONSHIPS
      ]
    end

    def case_approval_actions
      record_read_actions + [
        Permission::APPROVE_ASSESSMENT,
        Permission::APPROVE_CASE_PLAN,
        Permission::APPROVE_CLOSURE,
        Permission::APPROVE_ACTION_PLAN,
        Permission::CHANGE_LOG,
        Permission::ACCESS_LOG
      ]
    end

    def tracing_operational_actions
      [
        Permission::READ,
        Permission::CREATE,
        Permission::WRITE,
        Permission::ENABLE_DISABLE_RECORD,
        Permission::FLAG,
        Permission::FLAG_UPDATE,
        Permission::EXPORT_LIST_VIEW,
        Permission::EXPORT_CSV,
        Permission::EXPORT_EXCEL,
        Permission::EXPORT_PDF,
        Permission::CHANGE_LOG,
        Permission::ACCESS_LOG,
        Permission::VIEW_PHOTO,
        Permission::VIEW_AUDIO
      ]
    end

    def tracing_field_actions
      [
        Permission::READ,
        Permission::CREATE,
        Permission::WRITE,
        Permission::FLAG,
        Permission::FLAG_UPDATE,
        Permission::VIEW_PHOTO,
        Permission::VIEW_AUDIO
      ]
    end

    def tracing_supervise_actions
      [
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
    end

    def record_operational_actions
      [
        Permission::READ,
        Permission::CREATE,
        Permission::WRITE,
        Permission::ENABLE_DISABLE_RECORD,
        Permission::FLAG,
        Permission::FLAG_UPDATE,
        Permission::EXPORT_LIST_VIEW,
        Permission::EXPORT_CSV,
        Permission::EXPORT_EXCEL,
        Permission::EXPORT_PDF,
        Permission::CHANGE_LOG,
        Permission::ACCESS_LOG
      ]
    end

    def record_field_actions
      [
        Permission::READ,
        Permission::CREATE,
        Permission::WRITE,
        Permission::FLAG,
        Permission::FLAG_UPDATE
      ]
    end

    def national_dashboards
      [
        Permission::DASH_CASE_OVERVIEW,
        Permission::DASH_CASE_RISK,
        Permission::DASH_MATCHING_RESULTS,
        Permission::DASH_GROUP_OVERVIEW,
        Permission::DASH_REPORTING_LOCATION,
        Permission::DASH_FLAGS,
        Permission::DASH_CASE_INCIDENT_OVERVIEW,
        Permission::DASH_NATIONAL_ADMIN_SUMMARY,
        Permission::DASH_ACTION_NEEDED_NEW_UPDATED,
        Permission::DASH_ACTION_NEEDED_IDENTIFIED,
        Permission::DASH_ACTION_NEEDED_NEW_REFERRALS,
        Permission::DASH_ACTION_NEEDED_TRANSFER_AWAITING_ACCEPTANCE,
        Permission::DASH_SHARED_WITH_ME,
        Permission::DASH_SHARED_WITH_OTHERS,
        Permission::DASH_SHARED_WITH_MY_TEAM_OVERVIEW,
        Permission::DASH_WORKFLOW,
        Permission::DASH_CASES_TO_ASSIGN,
        Permission::DASH_CASES_BY_SOCIAL_WORKER,
        Permission::DASH_WORKFLOW_TEAM,
        Permission::DASH_TASKS
      ]
    end

    def team_dashboards
      [
        Permission::DASH_CASE_OVERVIEW,
        Permission::DASH_MATCHING_RESULTS,
        Permission::DASH_GROUP_OVERVIEW,
        Permission::DASH_REPORTING_LOCATION,
        Permission::DASH_FLAGS,
        Permission::DASH_SHARED_WITH_ME,
        Permission::DASH_SHARED_WITH_OTHERS,
        Permission::DASH_SHARED_WITH_MY_TEAM,
        Permission::DASH_SHARED_WITH_MY_TEAM_OVERVIEW,
        Permission::DASH_SHARED_FROM_MY_TEAM,
        Permission::DASH_CASES_TO_ASSIGN,
        Permission::DASH_CASES_BY_SOCIAL_WORKER,
        Permission::DASH_WORKFLOW,
        Permission::DASH_WORKFLOW_TEAM,
        Permission::DASH_TASKS
      ]
    end

    def field_dashboards
      [
        Permission::DASH_CASE_OVERVIEW,
        Permission::DASH_MATCHING_RESULTS,
        Permission::DASH_GROUP_OVERVIEW,
        Permission::DASH_REPORTING_LOCATION,
        Permission::DASH_FLAGS,
        Permission::DASH_SHARED_WITH_ME,
        Permission::DASH_WORKFLOW,
        Permission::DASH_TASKS
      ]
    end

    def operational_permissions(scope: :national)
      dashboards = scope == :national ? national_dashboards : team_dashboards

      [
        permission(Permission::TRACING_REQUEST, tracing_operational_actions),
        permission(Permission::POTENTIAL_MATCH, [Permission::MANAGE]),
        permission(Permission::CASE, case_operational_actions),
        permission(Permission::INCIDENT, record_operational_actions),
        permission(Permission::FAMILY, record_operational_actions + [Permission::REOPEN, Permission::CLOSE]),
        permission(Permission::REGISTRY_RECORD, record_operational_actions),
        permission(Permission::DASHBOARD, dashboards)
      ]
    end

    def upsert_administrator(cp_module, form_permissions)
      Role.create_or_update!(
        unique_id: 'role-lrf-administrator',
        name: role_attribute('role-lrf-administrator', :name, 'Administrador LRF'),
        description: role_attribute(
          'role-lrf-administrator',
          :description,
          'Administra a nivel nacional usuarios, roles, grupos y solicitudes LRF'
        ),
        permissions: [
          permission(Permission::TRACING_REQUEST, [Permission::MANAGE, Permission::VIEW_PHOTO, Permission::VIEW_AUDIO]),
          permission(Permission::POTENTIAL_MATCH, [Permission::MANAGE]),
          permission(Permission::CASE, [Permission::MANAGE]),
          permission(Permission::INCIDENT, [Permission::MANAGE]),
          permission(Permission::FAMILY, [Permission::MANAGE]),
          permission(Permission::REGISTRY_RECORD, [Permission::MANAGE]),
          permission(Permission::USER, [Permission::MANAGE]),
          permission(Permission::USER_GROUP, [Permission::MANAGE]),
          permission(Permission::ROLE, [Permission::MANAGE]),
          permission(Permission::AGENCY, [Permission::MANAGE]),
          permission(Permission::REPORT, [Permission::MANAGE]),
          permission(Permission::AUDIT_LOG, [Permission::READ]),
          permission(Permission::USAGE_REPORT, [Permission::READ]),
          permission(Permission::METADATA, [Permission::MANAGE]),
          permission(Permission::SYSTEM, [Permission::MANAGE]),
          permission(Permission::CONFIGURATION, [Permission::MANAGE]),
          permission(Permission::MATCHING_CONFIGURATION, [Permission::MANAGE]),
          permission(Permission::DASHBOARD, national_dashboards)
        ],
        group_permission: Permission::ALL,
        is_manager: true,
        modules: [cp_module],
        form_section_read_write: form_permissions[:operational_read_write]
      )
    end

    def upsert_monitor(cp_module, form_permissions)
      Role.create_or_update!(
        unique_id: 'role-lrf-monitor',
        name: role_attribute('role-lrf-monitor', :name, 'Monitor LRF'),
        description: role_attribute(
          'role-lrf-monitor',
          :description,
          'Monitorea y gestiona todas las solicitudes LRF a nivel nacional'
        ),
        permissions: operational_permissions(scope: :national) + [
          permission(Permission::REPORT, [Permission::READ])
        ],
        group_permission: Permission::ALL,
        modules: [cp_module],
        form_section_read_write: form_permissions[:operational_read_write]
      )
    end

    def upsert_regional_coordinator(cp_module, form_permissions)
      Role.create_or_update!(
        unique_id: 'role-ftr-manager',
        name: role_attribute('role-ftr-manager', :name, 'Coordinador Regional LRF'),
        description: role_attribute(
          'role-ftr-manager',
          :description,
          'Gestiona las solicitudes LRF de los grupos territoriales asignados'
        ),
        permissions: operational_permissions(scope: :team) + [
          permission(Permission::USER, [Permission::READ, Permission::AGENCY_READ]),
          permission(Permission::USER_GROUP, [Permission::READ]),
          permission(Permission::REPORT, [Permission::GROUP_READ])
        ],
        group_permission: Permission::GROUP,
        is_manager: true,
        reporting_location_level: 1,
        modules: [cp_module],
        form_section_read_write: form_permissions[:operational_read_write]
      )
    end

    def upsert_field_coordinator(cp_module, form_permissions)
      Role.create_or_update!(
        unique_id: 'role-ftr-worker',
        name: role_attribute('role-ftr-worker', :name, 'Coordinador Terreno LRF'),
        description: role_attribute(
          'role-ftr-worker',
          :description,
          'Registra y gestiona las solicitudes LRF en campo'
        ),
        permissions: [
          permission(Permission::TRACING_REQUEST, tracing_field_actions),
          permission(Permission::POTENTIAL_MATCH, [Permission::READ, Permission::VIEW_PHOTO, Permission::VIEW_AUDIO]),
          permission(Permission::CASE, case_field_actions),
          permission(Permission::INCIDENT, record_field_actions),
          permission(Permission::FAMILY, record_field_actions),
          permission(Permission::REPORT, [Permission::GROUP_READ]),
          permission(Permission::DASHBOARD, field_dashboards)
        ],
        group_permission: Permission::GROUP,
        reporting_location_level: 1,
        modules: [cp_module],
        form_section_read_write: form_permissions[:field_read_write]
      )
    end

    def upsert_manager(cp_module, form_permissions)
      Role.create_or_update!(
        unique_id: 'role-lrf-manager',
        name: role_attribute('role-lrf-manager', :name, 'Gerente LRF'),
        description: role_attribute(
          'role-lrf-manager',
          :description,
          'Supervisa nacionalmente y aprueba casos vinculados al flujo LRF'
        ),
        permissions: [
          permission(Permission::TRACING_REQUEST, tracing_supervise_actions),
          permission(Permission::POTENTIAL_MATCH, [Permission::READ, Permission::VIEW_PHOTO, Permission::VIEW_AUDIO]),
          permission(Permission::CASE, case_approval_actions),
          permission(Permission::INCIDENT, [Permission::READ, Permission::CHANGE_LOG, Permission::ACCESS_LOG]),
          permission(Permission::FAMILY, [Permission::READ, Permission::CHANGE_LOG, Permission::ACCESS_LOG]),
          permission(Permission::REGISTRY_RECORD, [Permission::READ, Permission::CHANGE_LOG, Permission::ACCESS_LOG]),
          permission(Permission::REPORT, [Permission::READ, Permission::GROUP_READ]),
          permission(
            Permission::DASHBOARD,
            [
              Permission::DASH_APPROVALS_ASSESSMENT,
              Permission::DASH_APPROVALS_CASE_PLAN,
              Permission::DASH_APPROVALS_CLOSURE,
              Permission::DASH_APPROVALS_ACTION_PLAN,
              Permission::DASH_NATIONAL_ADMIN_SUMMARY,
              Permission::DASH_CASE_OVERVIEW,
              Permission::DASH_REPORTING_LOCATION
            ]
          )
        ],
        group_permission: Permission::ALL,
        is_manager: true,
        modules: [cp_module],
        form_section_read_write: form_permissions[:operational_read]
      )
    end
  end
end
