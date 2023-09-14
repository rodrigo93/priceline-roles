# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "John Snow" }
    identifier { '1234' }
  end
end
