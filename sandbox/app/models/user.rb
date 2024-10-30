class User < ApplicationRecord
  validate :validate_name

  class << self
    def transaction_with_user1
      User.delete_all
      ActiveRecord::Base.transaction do
        User.create(name: "user1")
        ActiveRecord::Base.transaction do
          User.create(name: "user2")
          raise ActiveRecord::Rollback
        end
      end
    ensure
      p User.all.map(&:name) # => ["user1", "user2"]
    end

    def transaction_with_user2
      User.delete_all
      ActiveRecord::Base.transaction do
        User.create(name: "user1")
        ActiveRecord::Base.transaction(requires_new: true) do
          User.create(name: "user2")
          raise ActiveRecord::Rollback
        end
      end
    ensure
      p User.all.map(&:name) # => ["user1"]
    end

    def transaction_with_user3
      User.delete_all
      ActiveRecord::Base.transaction(requires_new: true) do
        User.create(name: "user1")
        ActiveRecord::Base.transaction(requires_new: true) do
          User.create(name: "user2")
          raise ActiveRecord::Rollback
        end
      end
    ensure
      p User.all.map(&:name) # => ["user1"]
    end

    def transaction_with_user4
      User.delete_all
      ActiveRecord::Base.transaction(requires_new: true) do
        User.create(name: "user1")
        ActiveRecord::Base.transaction do
          User.create(name: "user2")
          raise ActiveRecord::Rollback
        end
      end
    ensure
      p User.all.map(&:name) # => ["user1", "user2"]
    end

    def transaction_with_user5
      User.delete_all
      ActiveRecord::Base.transaction do
        User.create!(name: "user1")
        ActiveRecord::Base.transaction do
          User.create!(name: "invalid")
        end
      end
    ensure
      p User.all.map(&:name) # => []
    end

    def transaction_with_user6
      User.delete_all
      ActiveRecord::Base.transaction do
        User.create(name: "user1")
        ActiveRecord::Base.transaction do
          User.create(name: "invalid")
          raise ActiveRecord::Rollback
        end
      end
    ensure
      p User.all.map(&:name) # => ["user1"]
    end

    def transaction_with_user7
      User.delete_all
      ActiveRecord::Base.transaction(requires_new: true) do
        User.create!(name: "user1")
        ActiveRecord::Base.transaction(requires_new: true) do
          User.create!(name: "invalid")
          raise ActiveRecord::Rollback
        end
      end
    ensure
      p User.all.map(&:name) # => []
    end

    def transaction_with_user8
      User.delete_all
      ActiveRecord::Base.transaction do
        User.create!(name: "user1")
        ActiveRecord::Base.transaction(requires_new: true) do
          User.create!(name: "invalid")
          raise ActiveRecord::Rollback
        end
      end
    ensure
      p User.all.map(&:name) # => []
    end
  end

  private

  def validate_name
    # name が invalid の場合のみ validation error を追加
    if name == "invalid"
      errors.add(:name, "name is invalid")
    end
  end
end
