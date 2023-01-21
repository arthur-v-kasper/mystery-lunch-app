# frozen_string_literal: true

module ManagerLunch
  class SetLastEmployee < ApplicationService
    attr_accessor :year_month, :mls_employee

    def initialize(year_month, mls_employee = nil)
      @year_month = year_month
      @mls_employee = mls_employee
    end

    def call    
      @mls_employee = last_employee_not_selected if @mls_employee.nil?
      department_id = employee_department_id
      mystery_lunch = lunch_from_diferent_departament(department_id)
      ManagerLunch::SetEmployee.call(mystery_lunch.mystery_lunch_id,
                                     @mls_employee.employee.id)
    end

    private

    def last_employee_not_selected
      MysteryLunchEmployeeSchedule.not_selected.first
    end

    def lunch_from_diferent_departament(department_id)
      ManagerLunch::FindMLunchDiferentDepartament.call(department_id, @year_month)
    end

    def employee_department_id
      @mls_employee.employee.department.id
    end
  end
end
