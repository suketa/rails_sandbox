class BooksController < ApplicationController
  def index
    initialize_data

    try_book_reload
    try_book_reload_author
    try_book_editions_reload
  end

  private

  def initialize_data
    Author.first&.destroy
    author = Author.create(name: 'Dave Tomas')
    book = Book.create(title: 'Pragmatic Programer', author: author)
    Edition.create([{ name: '1st', book: book }, { name: '2nd', book: book }])
  end

  # try book.reload
  def try_book_reload
    book = Book.first
    @old_title = book.title
    Book.fix_title
    @new_title = book.reload.title
  end

  # try book.reload_author
  def try_book_reload_author
    book = Book.first
    author_id = Author.first.id
    @old_author_name = Author.find(author_id).name
    Author.fix_name
    @reloaded_author_name = book.reload_author.name
    @new_author_name = Author.find(author_id).name
  end

  # try book.editions.reload
  def try_book_editions_reload
    book = Book.first
    @old_editions = book.editions.reload.map(&:name)
    Edition.fix_name
    @new_editions = book.editions.reload.map(&:name)
  end
end
