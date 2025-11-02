class User < ApplicationRecord
  has_many :user_projects, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  normalizes :email, with: ->(email) { email.strip.downcase }
end
