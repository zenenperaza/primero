# frozen_string_literal: true

load File.join(__dir__, 'lrf_role_permissions.rb')

puts 'Applying ASONACOP LRF role permissions'

roles = VenezuelaLrfRolePermissions.apply!

roles.each_value do |role|
  puts "Updated #{role.unique_id}: #{role.name}"
end
