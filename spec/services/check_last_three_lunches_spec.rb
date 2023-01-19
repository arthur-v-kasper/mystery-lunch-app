# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManagerLunch::CheckLastThreeLunches do
  let!(:ml_employee_schedule) {create_list(:mystery_lunch_employee_schedule, 4)}
  let!(:ml_employees_selected) { ml_employee_schedule.first(2) }
  
  describe '#call' do
    context 'when there are mystery lunch with the same employees' do
      before do
        create(:mystery_lunch, 
               :with_same_employees, 
               year_month: MysteryLunch::THREE_YEARMONTHS_AGO, 
               ml_employee_schedule: ml_employee_schedule )
      end
      it 'returns a correspondly year month' do 
        expect(described_class.call(ml_employees_selected)).to eq([MysteryLunch::THREE_YEARMONTHS_AGO])
      end
    end

    context 'when there was no mystery lunch with the same employees' do
      before do
        create(:mystery_lunch, 
               :with_others_employees, 
               year_month: MysteryLunch::THREE_YEARMONTHS_AGO, 
               ml_employee_schedule: ml_employee_schedule )
      end
      it 'returns blank' do        
        expect(described_class.call(ml_employees_selected)).to eq([])
      end
    end
  end
end