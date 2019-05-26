class UserMailer < ApplicationMailer
  after_action :set_perform_deliveries

  def created_email
    @user = params[:user]
    mail(to: 'admin@example.com', subject: 'user created')
  end

  private

  def set_perform_deliveries
    mail.perform_deliveries = params[:perform_deliveries]
  end
end
