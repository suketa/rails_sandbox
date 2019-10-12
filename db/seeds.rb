author = Author.create(
  {
    name: 'Dave Thomas'
  }
)

Book.create(
  [
    { title: 'Programming Ruby', author: author, published: true },
    { title: 'Pragmatic Programmer', author: author, published: true },
    { title: 'Agile Web Development with Rails 6', author: author, published: false }
  ]
)
