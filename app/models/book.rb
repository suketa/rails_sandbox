class Book < ApplicationRecord
  belongs_to :author
  has_many :editions, dependent: :destroy
end
