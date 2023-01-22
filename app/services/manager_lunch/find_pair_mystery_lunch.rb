# frozen_string_literal: true

module ManagerLunch
  class FindPairMysteryLunch < ApplicationService
    attr_accessor :department_id, :year_month, :from_diff_department

    def initialize(year_month, department_id = nil)
      @department_id = department_id
      @year_month = year_month
      @from_diff_department = from_diff_department
      @ml_employees = MysteryLunchEmployee.pair_current_yearmonth(@year_month)
    end

    def call
      return random_ml_employees unless @department_id

      @ml_employees = find_ml_from_diff_department || random_ml_employees
    end

    private

    def find_ml_from_diff_department
      ml_from_diff_department = nil
      @ml_employees.each_with_index do |mle, index|
        mystery_lunch_id = mle.mystery_lunch_id
        ml_employees = MysteryLunchEmployee.where(mystery_lunch_id:)
        if mystery_lunch_diff_department?(ml_employees)
          ml_from_diff_department = mle
          break
        end
        ml_from_diff_department = mle if index == @ml_employees.size - 1
      end
      ml_from_diff_department
    end

    def mystery_lunch_diff_department?(ml)
      departments = [@department_id]
      ml.each { |m| departments << m.employee.department_id }
      departments.uniq.count === departments.count
    end

    def random_ml_employees
      @ml_employees.sample
    end
  end
end
