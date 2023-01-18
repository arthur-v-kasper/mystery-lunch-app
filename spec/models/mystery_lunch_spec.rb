# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MysteryLunch do
  let(:default_mystery_lunch) { create(:mystery_lunch, :empty) }
  let(:custom_mystery_lunch) { create(:mystery_lunch) }

  describe 'has associations' do
    it { should have_many(:mystery_lunch_employees) }
  end

  context 'when year month its not informed' do
    it 'set current year month' do
      expect(default_mystery_lunch.year_month).to eq(MysteryLunch::CURRENT_YEARMONTH)
    end
  end

  context 'when year month is informed' do
    it 'set correct year month' do
      expect(custom_mystery_lunch.year_month).to eq(202_212)
    end
  end
end
