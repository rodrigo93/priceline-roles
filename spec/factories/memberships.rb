# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    user
    team
    role
  end
end
