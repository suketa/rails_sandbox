Book.delete_all
Book.create(title: 'Agile Web Development with Rails 6', price: '12,345,678.12')
Book.create(title: 'Programming Ruby', price: '12.345.678,12')

puts Book.all.map { |book| "#{book.title} => #{book.price}" }
