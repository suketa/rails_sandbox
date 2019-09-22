class ActionControllerSubscriber < ActiveSupport::Subscriber
  attach_to :action_controller

  def process_action(event)
    action = "#{event.payload[:controller]}##{event.payload[:action]}"
    Rails.logger.info("#{action} cpu_time=#{event.cpu_time} duration=#{event.duration} allocations=#{event.allocations}")
  end
end
