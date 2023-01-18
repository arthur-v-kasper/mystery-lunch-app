# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(40) }
  end

  describe 'associations' do
    it { should have_many(:employees) }
  end
end
