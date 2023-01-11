class Employee < ApplicationRecord
  belongs_to :department
  belongs_to :user

  validates :full_name, :email, presence: true
  validates_format_of :email, with: /\A(\S+)@(.+)\.(\S+)\z/
  validates :full_name, length: { in: 3..80 }
end