# frozen_string_literal: true

FactoryBot.define do
  factory :mystery_lunch_employees do
    association :employee
    association :mystery_lunch

    trait :with_employee do
      association :employee, :with_department_and_user, factory: :employee
      association :mystery_lunch, factory: :mystery_lunch
    end
  end
end
