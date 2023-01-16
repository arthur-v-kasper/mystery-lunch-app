# frozen_string_literal: true

FactoryBot.define do
  factory :mystery_lunch do
    year_month { 202_212 }

    trait :empty do
      year_month { nil }
    end
  end
end
