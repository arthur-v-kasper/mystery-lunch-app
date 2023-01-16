# frozen_string_literal: true

require 'rails_helper'


RSpec.describe MysteryLunchEmployeeSchedule do  
  let(:ml_employee_schedule) { create(:mystery_lunch_employee_schedule, :with_employee) }

  describe "selected!" do
    it "marks the employee as selected" do
      expect { ml_employee_schedule.selected! }.to change { ml_employee_schedule.selected }.from(0).to(1)
    end
  end

  describe "not_selected" do
    it "returns only the employees that are not selected" do
      ml_employee_schedule.selected!
      expect(MysteryLunchEmployeeSchedule.not_selected).not_to include(ml_employee_schedule)
    end
  end

  describe "unselect_all!" do
    it "sets all employees to not selected" do
      ml_employee_schedule.selected!
      MysteryLunchEmployeeSchedule.unselect_all!
      ml_employee_schedule.reload
      expect(ml_employee_schedule.selected).to eq(0)
    end
  end
end