class User < ApplicationRecord
  scope :adult, -> { where(age: [20..]) }
  scope :juvenile, -> { where('age < 20') }
end
