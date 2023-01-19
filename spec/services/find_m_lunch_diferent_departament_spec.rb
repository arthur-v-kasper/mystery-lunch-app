# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManagerLunch::FindMLunchDiferentDepartament do
  let(:year_month) { 202_212 }
  let!(:department) { create(:department) }
  let!(:mystery_lunch_employees) { create_list(:mystery_lunch_employee, 6) }

  context 'when there are mystery lunch from different department' do
    before do
      mystery_lunch_employees.first(2).each do |mle|
        mle.employee.update!(department:)
      end

      mystery_lunch_employees.each_slice(2) do |mle|
        pair_mystery_lunch = create(:mystery_lunch)
        mle[0].update!(mystery_lunch: pair_mystery_lunch)
        mle[1].update!(mystery_lunch: pair_mystery_lunch)
      end
    end

    it 'returns the first mystery lunch ID from different department' do
      service = described_class.call(department.id, year_month)
      expect(service.mystery_lunch_id).to eq(8)
    end
  end
end
