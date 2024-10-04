class Project < ApplicationRecord
  has_many :assignments
  has_many :employees, through: :assignments
  validates :name, presence: true, length: { maximum: 255 } # MySQLだとstringがVARCHAR(255)なので、255文字以内に制限
  validates :start_date, presence: true # 開始予定が未来の日付も許容する仕様もあり得るので、未来の日付も許容する
end
