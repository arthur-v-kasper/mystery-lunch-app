# frozen_string_literal: true

module ManagerLunch
  class SetEmployee < ApplicationService
    attr_accessor :mystery_lunch_id, :employee_id

    def initialize(mystery_lunch_id, employee_id)
      @mystery_lunch_id = mystery_lunch_id
      @employee_id = employee_id
    end

    def call
      MysteryLunchEmployeeSchedule.find_by(employee_id:).selected!
      MysteryLunchEmployee.create!(mystery_lunch_id: @mystery_lunch_id,
                                   employee_id: @employee_id)
    end
  end
end
