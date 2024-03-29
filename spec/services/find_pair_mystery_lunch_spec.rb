# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManagerLunch::FindPairMysteryLunch do
  let(:year_month) { 202_212 }
  let!(:department) { create(:department) }
  let!(:mystery_lunch_employees) { create_list(:mystery_lunch_employee, 6) }

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

  it 'returns a mystery lunch ID with a pair of employees' do
    service = described_class.call(year_month)
    expect(MysteryLunchEmployee.where(mystery_lunch_id: service.mystery_lunch_id).count).to eq(2)
  end

  it 'returns a mystery lunch ID from different department' do
    service = described_class.call(year_month, department.id)
    expect(service.mystery_lunch_id).to eq(8)
  end
end
