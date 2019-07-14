class User < ApplicationRecord
  scope :is_distinct_from, ->(name) {
    users = Arel::Table.new(:users)
    where(users[:name].is_distinct_from(name))
  }

  scope :is_not_distinct_from, ->(name) {
    users = Arel::Table.new(:users)
    where(users[:name].is_not_distinct_from(name))
  }
end
