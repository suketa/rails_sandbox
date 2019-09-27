class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  scope :of_books_with, ->(title) { joins(:books).where('books.title like ?', "%#{title}%") }
  scope :of_ruby_books, -> { of_books_with('Ruby') }
  scope :of_rails_books, -> { of_books_with('Rails') }
end
