Library.create(
  [
    {
      name: 'Tokyo',
      books: Book.create(
        [
          { title: 'Programming Ruby' },
          { title: 'The Pragmatic Programmer' },
          { title: 'Agile Web Development with Rails' }
        ]
      )
    },
    {
      name: 'Kanagawa',
      books: Book.create(
        [
          { title: 'Programming Ruby' }
        ]
      )
    },
    {
      name: 'Chiba',
      books: Book.create(
        [
          { title: 'Programming Ruby' },
          { title: 'The Pragmatic Programmer' }
        ]
      )
    }
  ]
)
