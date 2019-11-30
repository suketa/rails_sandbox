author = Author.new(name: 'Dave Thomas')
author.books.build(title: 'Pragmatic Programmer', isbn: '123')
author.books.build(title: 'Agile Web Development with Rails 6', isbn: '123')
author.save!
p author.persisted?
