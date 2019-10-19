class ApplicationController < ActionController::Base
  before_action :reopen_log

  def reopen_log
    Rails.logger.reopen Rails.configuration.default_log_file unless File.exist?(Rails.configuration.paths['log'].first)
  end
end
