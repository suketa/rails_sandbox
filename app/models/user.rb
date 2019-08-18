class User < ApplicationRecord
  #
  # How to run:
  #   bin/rails runner 'User.update_age`
  #
  # In Rails 6.0.0, this method raises StaleObjectError because
  # `update_all` method cares about optimistic locking.
  #
  # In Rails 5.2.3, no error occurs because
  # `update_all` method does not care about optimistic locking.
  #
  def self.update_age
    taro = User.find_by(name: 'Taro')
    where(name: %w[Taro Hanako]).update_all(age: 11)
    taro.age = 12
    taro.save! # => StaleObjectError
  end
end
