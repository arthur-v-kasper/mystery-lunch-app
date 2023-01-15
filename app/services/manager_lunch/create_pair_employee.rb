# frozen_string_literal: true

module ManagerLunch
  class CreatePairEmployee < ApplicationService
    attr_accessor :year_month

    def initialize(year_month)
      @year_month = year_month
      @random_employees = ManagerLunch::RandomPairEmployee.call
      @mystery_lunch = ManagerLunch::Create.call(@year_month)
    end

    def call
      set_employees_to_mystery_lunch
    end

    private

    def set_employees_to_mystery_lunch
      @random_employees.each do |random_employee|
        ManagerLunch::SetEmployee.call(@mystery_lunch.id,
                                       random_employee.employee_id)
      end
    end
  end
end
