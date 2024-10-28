class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
