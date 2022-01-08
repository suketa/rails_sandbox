class User < ApplicationRecord
  CONFIRMATION_TOKEN_EXPIRATION_IN_SECONDS = 10.minutes.to_i
  MAILER_FROM_EMAIL = 'no-reply@example.com'.freeze

  has_secure_password
  has_secure_token :confirmation_token

  before_save :downcase_email

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true

  def confirm!
    regenerate_confirmation_token
    update_columns(confirmed_at: Time.current)
  end

  def confirmed?
    confirmed_at.present?
  end

  def confirmation_token_is_valid?
    return false if confirmation_sent_at.nil?

    (Time.current - confirmation_sent_at) <= CONFIRMATION_TOKEN_EXPIRATION_IN_SECONDS
  end

  def unconfirmed?
    !confirmed?
  end

  def send_confirmation_email!
    regenerate_confirmation_token
    update_columns(confirmation_sent_at: Time.current)
    UserMailer.confirmation(self).deliver_now
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
