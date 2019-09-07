juveniles = User.juvenile
adults = User.adult

users1 = User.all.excluding(juveniles)
p users1.map(&:name) # => ["Andy", "Dave", "Ellen"]

users2 = juveniles.including(adults)
p users2.map(&:name) # => ["Bob", "Cindy", "Andy", "Dave", "Ellen"]

# withous is same as excluding
users3 = User.all.without(juveniles)
p users3.map(&:name) # => ["Andy", "Dave", "Ellen"]
