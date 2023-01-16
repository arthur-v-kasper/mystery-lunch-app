# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    user_name { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
