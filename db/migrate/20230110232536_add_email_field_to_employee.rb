# frozen_string_literal: true

class AddEmailFieldToEmployee < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :email, :string, null: false
  end
end
