class Book < ApplicationRecord
  scope :long_time_all, lambda {
    sleep 3
    all
  }
end
