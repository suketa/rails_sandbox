class UserMailer < ApplicationMailer
  default from: User::MAILER_FROM_EMAIL

  def confirmation(user)
    @user = user

    mail to: @user.email, subject: 'Confirmation instructions'
  end

  def password_reset(user)
    @user = user

    mail to: @user.email, subject: 'Password Reset instructions'
  end
end
