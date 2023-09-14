# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name       { Faker::Name.name }
    identifier { Faker::IDNumber.unique.valid }
  end
end
