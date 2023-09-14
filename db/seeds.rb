# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create roles
roles = %w[Developer Product Owner Tester]

roles.each do |role_name|
  Role.find_or_create_by(name: role_name)
end
