# app/models/user.rb
class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true, uniqueness: false
  validates :last_name, presence: true, uniqueness: false
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  # Add this class method to create password digests
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
