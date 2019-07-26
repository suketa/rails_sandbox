class User < ApplicationRecord
  LARGE = 9223372036854775808
  SMALL = -9223372036854775809
  scope :age_in_large, -> { where(age: [1..LARGE]) }
  scope :age_eq_large, -> { where(age: LARGE) }
  scope :age_not_eq_large, -> { where.not(age: LARGE) }
  scope :age_in_small, -> { where(age: [SMALL..1]) }
  scope :age_in_small_large, -> { where(age: [SMALL..LARGE]) }
end
