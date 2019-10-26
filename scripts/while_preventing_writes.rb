puts User.count

if ActiveRecord::Base.connection.object_id != User.connection.object_id
  puts 'ActiveRecord::Base.connection != User.connection'
end

# ActiveRecord::Base.connection.while_preventing_writes do # Rails 6.0.0.rc1
ActiveRecord::Base.connection_handler.while_preventing_writes do # Rails 6.0.0
  User.create!(name: 'Taro')
end

puts User.count
