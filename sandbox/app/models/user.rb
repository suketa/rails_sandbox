class User < ApplicationRecord
  has_many :posts, dependent: :destroy do
    def recent
      where('created_at >= ?', 7.days.ago)
    end
    def find_or_create_by_title(title)
      find_by(title: title) || create(title: title)
    end
  end
end
