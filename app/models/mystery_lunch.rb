# frozen_string_literal: true

class MysteryLunch < ApplicationRecord
  has_many :mystery_lunch_employees

  validates :year_month, presence: true

  before_validation :default_year_month

  CURRENT_YEARMONTH = Time.now.strftime('%Y%m').to_i

  private
  
  def default_year_month
    self.year_month = CURRENT_YEARMONTH if self.year_month.blank?
  end
end
