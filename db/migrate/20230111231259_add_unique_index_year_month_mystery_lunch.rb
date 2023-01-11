class AddUniqueIndexYearMonthMysteryLunch < ActiveRecord::Migration[7.0]
  def change
    add_index :mystery_lunches, :year_month, unique: true
  end
end
