User.create(name: 'Taro')

ActiveRecord::Base.connected_to(database: :library) do
  User.create(name: 'Hanako')
end

Book.create(title: 'Programming Ruby')
