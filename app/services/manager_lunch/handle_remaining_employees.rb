# frozen_string_literal: true

module ManagerLunch
  class HandleRemainingEmployees < ApplicationService
    attr_accessor :employee_id

    def initialize(employee_id)
      @employee_id = employee_id
      @mystery_lunch_by_employee = mystery_lunch_by_employee
      @mystery_lunch_group = get_mystery_lunch_group(@mystery_lunch_by_employee.mystery_lunch_id)
    end

    def call
      if mystery_lunch_with_three?
        @mystery_lunch_by_employee.destroy
      else
        remaining_employee = get_remaining_employee
        @mystery_lunch_group.destroy_all
        ManagerLunch::SetLastEmployee.call(MysteryLunch::CURRENT_YEARMONTH,
                                           remaining_employee)
      end
    end

    private

    def mystery_lunch_by_employee
      MysteryLunchEmployee.current_yearmonth_by_employee(@employee_id).first
    end

    def get_mystery_lunch_group(mystery_lunch_id)
      MysteryLunchEmployee.where(mystery_lunch_id:)
    end

    def get_remaining_employee
      @mystery_lunch_group.where.not(employee_id: @employee_id).first
    end

    def mystery_lunch_with_three?
      @mystery_lunch_group.count == 3
    end
  end
end
