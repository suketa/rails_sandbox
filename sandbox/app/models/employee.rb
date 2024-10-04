class Employee < ApplicationRecord
  belongs_to :department
  has_many :assignments

  validates :name, presence: true, length: { maximum: 255 } # MySQLだとstringがVARCHAR(255)なので、255文字以内に制限
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 } # 上限決めてもいいかも

  scope :age_over_or_equal_to, ->(age) { where(age: [ age.. ]) }
  scope :in_project, ->(project_name) { joins(assignments: [ :project ]).where(projects: { name: project_name }) }
  scope :having_role, ->(role) { joins(:assignments).where(assignments: { role: role }) }

  class << self
    def all_with_department_and_project
      # all
      eager_load(:department, assignments: %i[ project ])
    end
  end
end
