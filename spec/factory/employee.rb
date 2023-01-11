# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    full_fake_name = Faker::Name.name
    full_name { full_fake_name }
    email { Faker::Internet.email(name: full_fake_name, separators: '_', domain: 'creditshelf') }
    association :department
    association :user

    trait :with_department_and_user do
      association :department, factory: :department
      association :user, factory: :user
    end

    trait :empty do
      full_name { nil }
      email { nil }
    end
  end
end
