# frozen_string_literal: true

class Department < ApplicationRecord
  has_many :employees

  validates :name, presence: true
  validates :name, length: { in: 3..50 }
end
