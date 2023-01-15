# frozen_string_literal: true

module FakeData
  class Employees < ApplicationService
    def initialize; end

    def call
      puts 'Creating fake employees...'
      75.times do
        department = get_randomly_department
        full_name = Faker::Name.name
        email = Faker::Internet.email(name: full_name,
                                      separators: '_', domain: 'creditshelf.com')
        Employee.create!(full_name:, email:, department:)
      end
    end

    private

    def get_randomly_department
      Department.find_by(name: Department.all.sample.name)
    end
  end
end
