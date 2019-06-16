# class MyMailDeliveryJob < ActionMailer::MailDeliveryJob
class MyMailDeliveryJob < ActionMailer::DeliveryJob
  before_perform :logger_info

  def logger_info
    Rails.logger.info('BEFORE MyMailDeliveryJob perform')
  end
end
