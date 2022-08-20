class Book < ApplicationRecord
  scope :long_time_all, lambda {
    sleep 2
    all
  }
end
