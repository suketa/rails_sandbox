class Author < ApplicationRecord
  self.primary_key = %i[first_name last_name]
  has_many :books, foreign_key: %i[first_name last_name]
end
