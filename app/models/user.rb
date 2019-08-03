class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :country, presence: true
  validates :city, presence: true
end
