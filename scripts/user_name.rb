User.delete_all
User.create(name: 'John')
u = User.last
p u.cached_name
p u.cached_name
p u.name
