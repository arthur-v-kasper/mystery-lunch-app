# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManagerLunch::HandleRemainingEmployees do
  describe '#call' do
    context 'when is a pair mystery lunch' do
      before do
        create_list(:mystery_lunch, 4, :pair_employees)
      end

      it 'should realocate the remaining employee to another mystery lunch' do
        employees_from_ml = MysteryLunch.first.mystery_lunch_employees
        expect(employees_from_ml.second.mystery_lunch_id).to eq(1)

        ManagerLunch::HandleRemainingEmployees.call(employees_from_ml.first.employee_id)
        new_mle = MysteryLunchEmployee.find_by(employee_id: employees_from_ml.second.employee_id)
        expect(new_mle.mystery_lunch_id).to eq(2)
      end
    end

    context 'when is a trio mystery lunch' do
      before do
        create(:mystery_lunch, :trio_employees)
      end

      it 'should delete the employee from mystery lunch' do
        employees_from_ml = MysteryLunch.first.mystery_lunch_employees
        deleted_employee = employees_from_ml.first.employee_id
        expect(employees_from_ml.count).to  eq(3)

        ManagerLunch::HandleRemainingEmployees.call(deleted_employee)
        expect(employees_from_ml.count).to  eq(2)
        expect(MysteryLunchEmployee.where(employee_id: deleted_employee)).to eq([])
      end
    end
  end
end
