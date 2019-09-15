now = Time.now

users = 10_000.times.each.map do |i|
  { name: "name#{i}", created_at: now, updated_at: now }
end

User.insert_all(users)
