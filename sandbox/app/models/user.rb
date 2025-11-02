class User < ApplicationRecord
  has_many :user_projects, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  normalizes :email, with: ->(email) { email.strip.downcase }

  scope :much_name, ->(name) { where("name ILIKE ?", "%#{name}%") }
  scope :ordered_by_id, ->(id_order) { order(id: Arel.sql(id_order)) }

  class << self
    def search(name: nil, id_order: "asc")
      id_order = id_order.presence_in(%w[asc desc]) || "asc"
      users = all
      users = users.much_name(name) if name.present?
      users = users.ordered_by_id(id_order)
      users
    end
  end
end
