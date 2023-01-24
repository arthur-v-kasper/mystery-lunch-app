# frozen_string_literal: true

module ManagerLunch
  class MysteryLunchesMonth < ApplicationService
    attr_accessor :year_month

    def initialize(year_month = MysteryLunch::CURRENT_YEARMONTH)
      @year_month = year_month 
    end

    def call
      return if already_loaded?
      MysteryLunchEmployeeSchedule.unselect_all!
      loop do
        ManagerLunch::CreatePairEmployee.call(year_month)
        ManagerLunch::SetLastEmployee.call(year_month) if quantity_employees_not_selected == 1
        break if quantity_employees_not_selected.zero?
      end      
    end

    private

    def quantity_employees_not_selected
      MysteryLunchEmployeeSchedule.not_selected.count
    end

    def already_loaded?
      MysteryLunch.where(year_month: @year_month).count > 0
    end
  end
end
