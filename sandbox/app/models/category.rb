class Category < ApplicationRecord
  has_many :tasks

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
end
