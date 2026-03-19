class Todo < ApplicationRecord
  scope :done, ->{ where.not(done_at: nil) }
  scope :undone, ->{ where(done_at: nil) }
  scope :ordered, ->{ order(created_at: :desc) }
end
