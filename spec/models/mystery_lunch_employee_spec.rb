# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MysteryLunchEmployee, type: :model do
  describe 'has associations' do
    it { should belong_to(:employee) }
    it { should belong_to(:mystery_lunch) }
  end
end
