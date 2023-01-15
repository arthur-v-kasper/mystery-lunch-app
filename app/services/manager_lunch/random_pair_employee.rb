# frozen_string_literal: true

module ManagerLunch
  class RandomPairEmployee < ApplicationService
    def initialize
      @random_employees = []
    end

    def call
      loop do
        @random_employees = pair_employee
        result = check_last_three_lunches
        break if result.blank?
      end
      @random_employees
    end

    private

    def pair_employee
      MysteryLunchEmployeeSchedule.not_selected.sample(2)
    end

    def check_last_three_lunches
      ManagerLunch::CheckLastThreeLunches.call(@random_employees)
    end
  end
end
