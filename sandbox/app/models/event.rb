class Event < ApplicationRecord
  class << self
    def safe_create(params)
      tried = false
      Event.create(params)
    rescue ActiveRecord::StatementInvalid => e
      if tried
        Rails.logger.error("Event creation failed: #{e.message}.")
      end
      Rails.logger.info("Event creation failed: #{e.message}. Try to create partition.")
      create_partition(params[:account_id])
      tried = true
      retry
    end

    def create_partition(account_id)
      Event.connection.execute <<~SQL
        CREATE TABLE  events#{account_id} PARTITION OF events FOR VALUES IN (#{account_id});
      SQL
    end
  end
end
