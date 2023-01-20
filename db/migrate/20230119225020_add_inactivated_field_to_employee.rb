# frozen_string_literal: true

class AddInactivatedFieldToEmployee < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :inactivated, :integer
  end
end
