# frozen_string_literal: true

class CreateMysteryLunchEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :mystery_lunch_employees do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :mystery_lunch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
