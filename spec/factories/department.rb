# frozen_string_literal: true

FactoryBot.define do
  factory :department do
    name { Faker::IndustrySegments.sector }
  end
end
