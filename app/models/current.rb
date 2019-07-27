class Current < ActiveSupport::CurrentAttributes
  attribute :user_agent
  before_reset { log_user_agent }

  private

  def log_user_agent
    Rails.logger.info("#{Thread.current}: user_agent = #{Current.user_agent}")
  end
end
