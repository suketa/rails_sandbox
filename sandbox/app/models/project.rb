class Project < ApplicationRecord
  has_many :user_projects, dependent: :destroy

  validates :name, presence: true
end
