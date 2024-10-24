class Category < ApplicationRecord
  has_many :tasks

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true

  scope :with_task_nums, -> { left_joins(:tasks).group(:id).select("categories.*, COUNT(tasks.id) AS task_nums").order(:id) }
end
