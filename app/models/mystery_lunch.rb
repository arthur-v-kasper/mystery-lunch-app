# frozen_string_literal: true

class MysteryLunch < ApplicationRecord
  has_many :mystery_lunch_employees

  validates :year_month, presence: true  
end
