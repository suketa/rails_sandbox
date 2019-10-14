pragmatic, addison = Publisher.create(
  [
    { name: 'Pragmatic Bookshelf' },
    { name: 'Addison-Wesley Professional' }
  ]
)

author = Author.create(name: 'Dave Thomas')

Book.create(
  [
    {
      title: 'Agile Web Development with Rails 6',
      publisher: pragmatic,
      author: author
    },
    {
      title: 'Agile Web Development with Rails 5.1',
      publisher: pragmatic,
      author: author
    },
    {
      title: 'Pragmatic Programmer',
      publisher: addison,
      author: author
    }
  ]
)
