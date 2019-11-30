class Book < ApplicationRecord
  belongs_to :author

  validates :isbn, uniqueness: true
end
