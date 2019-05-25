class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  accepts_nested_attributes_for :books
end
