# frozen_string_literal: true

module ManagerLunch
  class Create < ApplicationService
    attr_accessor :year_month

    def initialize(year_month)
      @year_month = year_month
    end

    def call
      MysteryLunch.create!(year_month: @year_month)
    end
  end
end
