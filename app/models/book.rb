class Book < ApplicationRecord
  belongs_to :publisher
  belongs_to :author
end
