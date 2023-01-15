# frozen_string_literal: true

class CreateMysteryLunchEmployeeSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :mystery_lunch_employee_schedules do |t|
      t.integer :selected
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
