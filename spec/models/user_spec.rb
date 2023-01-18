# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'secure password' do
    it { should have_secure_password }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8).is_at_most(80) }
    it { should validate_length_of(:user_name).is_at_least(8).is_at_most(50) }
  end
end
