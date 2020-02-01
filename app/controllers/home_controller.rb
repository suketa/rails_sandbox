class HomeController < ApplicationController
  def index
    Rails.logger.level = 1
    Rails.logger.info("[Before] Rails.logger.debug? #{Rails.logger.debug?}")

    Fiber.new do
      Rails.logger.local_level = 0
      # Rails.logger.info("[Fiber] Rails.logger.debug? #{Rails.logger.debug?}")
      Rails.logger.debug("[Fiber] Rails.logger.debug? #{Rails.logger.debug?}")
    end.resume

    Rails.logger.info("[After] Rails.logger.debug? #{Rails.logger.debug?}")
  end
end
