# frozen_string_literal: true

class Employee < ApplicationRecord
  after_create :set_mystery_lunch_employee_schedule

  default_scope -> { where(inactivated: 0) }

  attribute :inactivated, default: 0

  belongs_to :department

  validates :full_name, :email, presence: true
  validates_format_of :email, with: /\A(\S+)@(.+)\.(\S+)\z/
  validates :full_name, length: { in: 3..80 }

  def inactivated!
    update!(inactivated: 1)
  end

  private

  def set_mystery_lunch_employee_schedule
    MysteryLunchEmployeeSchedule.create!(employee_id: id)
  end
end
