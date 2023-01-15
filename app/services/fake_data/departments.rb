# frozen_string_literal: true

module FakeData
  class Departments < ApplicationService
    def initialize; end

    def call
      puts 'Creating departments...'
      department = %w[Operations Sales Marketing Risk Management Finance HR Development Data]
      department.each { |department| Department.create!(name: department) }
    end
  end
end
