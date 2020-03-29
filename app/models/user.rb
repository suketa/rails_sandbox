class User < ApplicationRecord
  def cached_name
    name = Rails.cache.fetch("#{cache_key_with_version}/name") do
      User.find(id).name
    end
    name.upcase!
    Rails.cache.fetch("#{cache_key_with_version}/name") do
      User.find(id).name
    end
  end
end
