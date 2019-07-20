class UserMailer < ApplicationMailer
  def created_email
    @user = params[:user]
    # mail(to: 'admin@example.com', subject: 'user created') do |format|
    mail(to: 'admin@example.com', subject: 'user created', template_name: 'template') do |format|
      format.text
      format.html
    end
  end
end
