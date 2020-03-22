User.delete_all
ActiveRecord::Base.connection.enable_query_cache!

User.create(name: 'Andy')
user = User.first
p user.name

User.upsert_all(
  [
    {
      id: user.id,
      name: 'Bob',
      created_at: user.created_at,
      updated_at: Time.now
    }
  ]
)

user = User.first
p user.name
