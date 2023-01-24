# frozen_string_literal: true

class MysteryLunch < ApplicationRecord
  has_many :mystery_lunch_employees
  has_many :employees, through: :mystery_lunch_employees

  CURRENT_YEARMONTH ||= Time.now.strftime('%Y%m').to_i
  THREE_YEARMONTHS_AGO ||= Time.now.months_ago(3).strftime('%Y%m').to_i

  validates :year_month, presence: true

  before_validation :default_year_month

  private

  def default_year_month
    self.year_month = CURRENT_YEARMONTH if year_month.blank?
  end
end
