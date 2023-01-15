# frozen_string_literal: true

module ManagerLunch
  class CheckLastThreeLunches < ApplicationService
    attr_accessor :employees

    def initialize(employees)
      @employees = employees
    end

    def call
      MysteryLunchEmployee.joins(:mystery_lunch)
                          .where('mystery_lunches.year_month >= ? AND mystery_lunch_employees.employee_id IN (?)',
                                 MysteryLunch::THREE_YEARMONTHS_AGO, @employees.pluck(:employee_id))
                          .group('mystery_lunches.year_month')
                          .having('COUNT(DISTINCT mystery_lunch_id) = 1')
                          .pluck('mystery_lunches.year_month')
    end
  end
end
