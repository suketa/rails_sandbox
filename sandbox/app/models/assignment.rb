class Assignment < ApplicationRecord
  belongs_to :employee
  belongs_to :project
  validates :role, presence: true, length: { maximum: 255 } # MySQLだとstringがVARCHAR(255)なので、255文字以内に制限
  validates :employee_id, uniqueness: { scope: :project_id }

  scope :all_infos, ->{ includes(:project, :employee, employee: :department) }
end
