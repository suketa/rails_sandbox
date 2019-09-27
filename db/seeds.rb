Author.create(
  [
    {
      name: 'Dave Thomas',
      books: Book.create(
        [
          { title: 'Pragmatic Programmer' },
          { title: 'Programming Ruby' },
          { title: 'Agile Web Development with Rails 6' },
          { title: 'Agile Web Development with Rails 5.1' }
        ]
      )
    },
    {
      name: 'Yukihiro Matsumoto',
      books: Book.create(
        [
          { title: 'The Ruby Programming Language' }
        ]
      )
    },
    {
      name: 'Mark Lutz',
      books: Book.create(
        [
          { title: 'Programming Python' }
        ]
      )
    }
  ]
)
