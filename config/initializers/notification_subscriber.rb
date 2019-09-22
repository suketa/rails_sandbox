ActiveSupport::Notifications.subscribe 'process_middleware.action_dispatch' do |event|
  Rails.logger.info(event.payload[:middleware])
end
