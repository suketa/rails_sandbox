class Publisher < ApplicationRecord
  has_many :books

  scope :with_author, ->(author_id) { distinct.joins(books: :author).where(authors: { id: author_id }) }
end
