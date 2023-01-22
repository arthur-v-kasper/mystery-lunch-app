# frozen_string_literal: true

FactoryBot.define do
  factory :mystery_lunch do
    year_month { 202_212 }

    transient do
      ml_employee_schedule {}
    end

    trait :empty do
      year_month { nil }
    end

    trait :with_same_employees do
      after(:create) do |mystery_lunch, evaluator|
        create(:mystery_lunch_employee, mystery_lunch:,
                                        employee: evaluator.ml_employee_schedule.first.employee)
        create(:mystery_lunch_employee, mystery_lunch:,
                                        employee: evaluator.ml_employee_schedule.second.employee)
      end
    end

    trait :with_others_employees do
      after(:create) do |mystery_lunch, evaluator|
        create(:mystery_lunch_employee, mystery_lunch:,
                                        employee: evaluator.ml_employee_schedule.third.employee)
        create(:mystery_lunch_employee, mystery_lunch:,
                                        employee: evaluator.ml_employee_schedule.fourth.employee)
      end
    end

    trait :pair_employees do
      after(:create) do |mystery_lunch, _evaluator|
        mystery_lunch.update!(year_month: MysteryLunch::CURRENT_YEARMONTH)
        employees = create_list(:employee, 2)
        create(:mystery_lunch_employee, mystery_lunch:, employee: employees.first)
        create(:mystery_lunch_employee, mystery_lunch:, employee: employees.second)
      end
    end

    trait :trio_employees do
      after(:create) do |mystery_lunch, _evaluator|
        mystery_lunch.update!(year_month: MysteryLunch::CURRENT_YEARMONTH)
        employees = create_list(:employee, 3)
        create(:mystery_lunch_employee, mystery_lunch:, employee: employees.first)
        create(:mystery_lunch_employee, mystery_lunch:, employee: employees.second)
        create(:mystery_lunch_employee, mystery_lunch:, employee: employees.third)
      end
    end
  end
end
