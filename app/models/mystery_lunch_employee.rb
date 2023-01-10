class MysteryLunchEmployee < ApplicationRecord
  belongs_to :employee
  belongs_to :mystery_lunch
end
