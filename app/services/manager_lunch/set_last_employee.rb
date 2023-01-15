# frozen_string_literal: true

module ManagerLunch
  class SetLastEmployee < ApplicationService
    attr_accessor :year_month

    def initialize(year_month)
      @year_month = year_month
      @employee = last_employee_not_selected
    end

    def call
      department_id = @employee.employee.department.id
      mystery_lunch = lunch_from_diferent_departament(department_id)
      ManagerLunch::SetEmployee.call(mystery_lunch.mystery_lunch_id,
                                     @employee.employee.id)
    end

    private

    def last_employee_not_selected
      MysteryLunchEmployeeSchedule.not_selected.first
    end

    def lunch_from_diferent_departament(department_id)
      ManagerLunch::CheckDiferentDepartament.call(department_id, @year_month)
    end
  end
end