# frozen_string_literal: true

FactoryBot.define do
  factory :mystery_lunch_employee do
    association :employee
    association :mystery_lunch
  end
end
