# frozen_string_literal: true

FactoryBot.define do
  factory :mystery_lunch_employee_schedule do
    selected { 0 }
    association :employee

    trait :with_employee do
      association :employee, :with_department, factory: :employee
    end
  end
end
