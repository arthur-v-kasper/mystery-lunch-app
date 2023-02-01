# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    association :department
    full_fake_name = Faker::Name.name
    full_name { full_fake_name }
    email { Faker::Internet.email(name: full_fake_name, separators: '_', domain: 'creditshelf') }    
  end
end
