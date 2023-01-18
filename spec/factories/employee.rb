# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    full_fake_name = Faker::Name.name
    full_name { full_fake_name }
    email { Faker::Internet.email(name: full_fake_name, separators: '_', domain: 'creditshelf') }
    association :department

    trait :with_department do
      association :department, factory: :department
    end
  end
end
