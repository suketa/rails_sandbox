class Book < ApplicationRecord
  belongs_to :author, foreign_key: %i[author_first_name author_last_name]
end
