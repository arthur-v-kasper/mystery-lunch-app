class CreateMysteryLunches < ActiveRecord::Migration[7.0]
  def change
    create_table :mystery_lunches do |t|
      t.integer :year_month, null: false

      t.timestamps
    end
  end
end
