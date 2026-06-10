# frozen_string_literal: true

# Copyright (c) 2014 - 2023 UNICEF. All rights reserved.

# SupervisorToCaseworkerRatio
#
# A simple ratio between the number of supervisors and the number of case
# workers in an agency.
class Kpi::SupervisorToCaseworkerRatio < Kpi::Search
  SUPERVISOR_ROLES = [
    'role-gbv-case-management-supervisor',
    'role-ftr-manager',
    'role-lrf-administrator',
    'role-lrf-manager',
    'role-lrf-monitor'
  ].freeze

  CASE_WORKER_ROLES = %w[
    role-gbv-mobile-caseworker
    role-gbv-caseworker
    role-ftr-worker
  ].freeze

  def supervisors
    Agency.joins(users: [:role])
          .where(
            unique_id: owned_by_agency_id,
            users: { roles: { unique_id: SUPERVISOR_ROLES } }
          ).count
  end

  def case_workers
    Agency.joins(users: [:role])
          .where(
            unique_id: owned_by_agency_id,
            users: { roles: { unique_id: CASE_WORKER_ROLES } }
          ).count
  end

  def ratio(supervisor_count, case_worker_count)
    (supervisor_count.to_f / case_worker_count).rationalize
  end

  def to_json(*_args)
    supervisor_count = supervisors
    case_worker_count = case_workers

    return { data: { supervisors: supervisor_count, case_workers: case_worker_count } } if supervisor_count.zero? || case_worker_count.zero?

    ratio_value = ratio(supervisor_count, case_worker_count)

    {
      data: {
        supervisors: ratio_value.numerator,
        case_workers: ratio_value.denominator
      }
    }
  end
end
