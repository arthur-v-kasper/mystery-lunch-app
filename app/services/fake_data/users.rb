# frozen_string_literal: true

module FakeData
  class Users < ApplicationService
    def initialize; end

    def call
      puts 'Creating fake admin user...'
      User.create!(user_name: 'admin@kasper.com', password: 'fakepassword')
    end
  end
end
