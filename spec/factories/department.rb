# frozen_string_literal: true

FactoryBot.define do
  factory :department do
    name { Faker::IndustrySegments.sector }

    trait :empty do
      name { nil }
    end
  end
end
