class User < ApplicationRecord
  # validates :name, uniqueness: true
  # validates :name, uniqueness: { case_sensitive: true }
  validates :name, uniqueness: { case_sensitive: false }
end
