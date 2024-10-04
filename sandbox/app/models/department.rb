class Department < ApplicationRecord
  has_many :employees
  validates :name, presence: true, length: { maximum: 255 } # MySQLだとstringがVARCHAR(255)なので、255文字以内に制限

  class << self
    # 部署ID, 部署名, 部署に所属する社員数 の配列を取得する
    # Department.count_employees # => [[1, '部署名1', 3], [2, '部署名2', 5], [3, '部署名3', 2]]
    def count_employees
      joins(:employees).select(:id, :name,  "count(*) as employee_nums").group(:id)
    end
  end
end
