class Task < ApplicationRecord
  belongs_to :category, optional: true

  validates :title, presence: true, length: { maximum: 255 }
  enum :status, { not_started: 0, in_progress: 1, completed: 2 }, prefix: true, default: :not_started, validate: true

  scope :due_date_order, -> { order(due_date: :asc) }
end
