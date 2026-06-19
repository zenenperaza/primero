# frozen_string_literal: true

require 'rails_helper'

load Rails.root.join('configurations/venezuela/lrf_role_permissions.rb')

describe VenezuelaLrfRolePermissions do
  describe 'field coordinator case permissions' do
    let(:actions) { described_class.send(:case_field_actions) }

    it 'can request approvals' do
      expect(actions).to include(
        Permission::REQUEST_APPROVAL_ASSESSMENT,
        Permission::REQUEST_APPROVAL_CASE_PLAN,
        Permission::REQUEST_APPROVAL_ACTION_PLAN,
        Permission::REQUEST_APPROVAL_CLOSURE
      )
    end

    it 'cannot approve requests, self-approve, or manage all case actions' do
      expect(actions).not_to include(
        Permission::APPROVE_ASSESSMENT,
        Permission::APPROVE_CASE_PLAN,
        Permission::APPROVE_ACTION_PLAN,
        Permission::APPROVE_CLOSURE,
        Permission::SELF_APPROVE,
        Permission::MANAGE
      )
    end
  end
end
