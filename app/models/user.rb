class User < ApplicationRecord
  def self.all_in_library
    ActiveRecord::Base.connected_to(database: :library) do
      all
    end
  end
end
