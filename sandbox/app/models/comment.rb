class Comment < ApplicationRecord
  belongs_to :post

  validates :body, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
