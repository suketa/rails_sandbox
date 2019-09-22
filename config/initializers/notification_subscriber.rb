ActiveSupport::Notifications.subscribe 'process_action.action_controller' do |event|
  action = "#{event.payload[:controller]}##{event.payload[:action]}"
  Rails.logger.info("event.class=#{event.class}")
  Rails.logger.info("#{action} cpu_time=#{event.cpu_time} duration=#{event.duration} allocations=#{event.allocations}")
end
