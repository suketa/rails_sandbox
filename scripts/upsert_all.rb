now = Time.zone.now

inserted_books = Book.upsert_all(
  [
    { title: 'Pragmatic Programmer', isbn: '978-0201616224', created_at: now, updated_at: now },
    { title: 'Agile Web Development with Rails 5.1', isbn: '978-1680502510', created_at: now, updated_at: now }
  ],
  unique_by: :isbn,
  returning: %i[id title]
)

pp inserted_books
