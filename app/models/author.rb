class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  # accepts_nested_attributes_for :books # https://github.com/rails/rails/issues/20676
end
