# frozen_string_literal: true

module ManagerLunch
  class CheckDiferentDepartament < ApplicationService
    attr_accessor :department_id, :year_month

    def initialize(department_id, year_month)
      @department_id = department_id
      @year_month = year_month
    end

    def call
      MysteryLunchEmployee.joins(employee: :department).joins(:mystery_lunch)
                          .where("mystery_lunches.year_month = #{@year_month}")
                          .where("departments.id != #{@department_id}")
                          .group('mystery_lunch_employees.mystery_lunch_id')
                          .having('COUNT(DISTINCT departments.id) > 1')
                          .select('mystery_lunch_employees.mystery_lunch_id')
                          .first
    end
  end
end
