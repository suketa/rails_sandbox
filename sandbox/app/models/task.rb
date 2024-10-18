class Task < ApplicationRecord
  belongs_to :category, optional: true

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true

  validate :due_date_must_be_future

  enum :status, { not_started: 0, in_progress: 1, completed: 2 }, prefix: true, default: :not_started, validate: true

  scope :due_date_order, -> { order(due_date: :asc) }

  private

  def due_date_must_be_future
    return if due_date.blank?

    errors.add(:due_date, "can't be in the past") if due_date < Date.current
  end
end
