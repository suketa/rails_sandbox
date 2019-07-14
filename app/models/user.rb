class User < ApplicationRecord
  scope :second_millennium_after, -> { where(birth_at: (Time.new(2001, 1, 1)..)) }
end
