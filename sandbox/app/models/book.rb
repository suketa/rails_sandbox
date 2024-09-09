class Book < ApplicationRecord
  belongs_to :author, foreign_key: [:first_name, :last_name]
end
