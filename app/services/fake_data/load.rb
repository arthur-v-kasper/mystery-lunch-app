# frozen_string_literal: true

module FakeData
  class Load < ApplicationService
    def initialize; end

    def call
      ActiveRecord::Base.transaction do
        FakeData::Departments.call
        FakeData::Users.call
        FakeData::Employees.call
        FakeData::MysteryLunches.call
      end
    end
  end
end
