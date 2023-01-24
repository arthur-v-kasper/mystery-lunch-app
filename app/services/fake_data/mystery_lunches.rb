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
        ManagerLunch::MysteryLunchesMonth.call(year_month)
      end
    end
  end
end
