class Library < ApplicationRecord
  has_many :books, dependent: :destroy
end
