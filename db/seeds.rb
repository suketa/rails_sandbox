author = NonFictionAuthor.create(name: 'Dave Thomas')
book = Book.create(title: 'The Pragmatic Programmer', author: author)

author.update(
  books_attributes: [
    { id: book.id, title: 'The Pragmatic Programmer, 20th Anniversary Edition' }
  ]
)
