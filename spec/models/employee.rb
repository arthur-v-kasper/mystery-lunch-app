require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:full_name).is_at_least(3).is_at_most(80) }
    it { should allow_value("full_name@creditshelft.com").for(:email) }
    it { should_not allow_value("creditshelft.com").for(:email) }
  end

  describe 'has associations' do
    it { should belong_to(:department) }
  end

  describe 'after create' do
    it 'should set the mystery lunch employee schedule' do
      employee = create(:employee)
      expect(MysteryLunchEmployeeSchedule.find_by(employee_id: employee.id)).not_to be_nil
    end
  end
end