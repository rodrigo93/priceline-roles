# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    role
    team_id { SecureRandom.uuid }
    user_id { SecureRandom.uuid }
  end
end
