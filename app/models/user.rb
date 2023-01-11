# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_one :employee

  validates :user_name, :password, presence: true
  validates :password, length: { in: 8..80 }
  validates :user_name, length: { in: 8..50 }
end
