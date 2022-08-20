class User < ApplicationRecord
  scope :long_time_all, lambda {
    sleep 1
    all
  }
end
