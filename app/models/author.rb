class Author < ApplicationRecord
  has_many :books do
    def ordered
      order(:title)
    end
  end

  has_many :published_books, -> { where(published: true).extending(BooksAssociationExtension) }, class_name: 'Book'
end
