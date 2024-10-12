class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
