# frozen_string_literal: true

module FakeData
  class MysteryLunches < ApplicationService
    def initialize
      @past_months = 3
      @past_year_months = []
    end

    def call
      while @past_months > -1
        @past_year_months << Time.now.months_ago(@past_months).strftime('%Y%m').to_i
        @past_months -= 1
      end

      @past_year_months.each do |year_month|
        puts "Creating fake mystery lunches for #{year_month}..."
        MysteryLunchEmployeeSchedule.unselect_all!
        loop do
          ManagerLunch::CreatePairEmployee.call(year_month)
          ManagerLunch::SetLastEmployee.call(year_month) if quantity_employees_not_selected == 1

          if quantity_employees_not_selected.zero?            
            break
          end
        end
      end
    end

    private

    def quantity_employees_not_selected
      MysteryLunchEmployeeSchedule.not_selected.count
    end
  end
end
