class Author < ApplicationRecord
  self.primary_key = [:first_name, :last_name]
  has_many :books, foreign_key: [:first_name, :last_name]
end
