# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManagerLunch::RandomPairEmployee do
  let(:employees) { create_list(:mystery_lunch_employee_schedule, 10) }

  describe '#call' do
    before do
      allow(MysteryLunchEmployeeSchedule).to receive(:not_selected).and_return(employees.sample(2))
    end
    it 'should return a two random employees' do
      expect(described_class.call.count).to eq(2)
    end
  end
end
