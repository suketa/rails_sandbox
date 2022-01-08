class PasswordsController < ApplicationController
  before_action :redirect_if_authenticated

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user.present?
      if @user.confirmed?
        @user.send_password_reset_email!
        redirect_to root_path, notice: 'we have sent email'
      else
        redirect_to new_confirmation_path, alert: 'Please confirm'
      end
    else
      redirect_to root_path, notice: 'we have sent email'
    end
  end

  def edit
    @user = User.find_by(password_reset_token: params[:password_reset_token])
    if @user.present? && @user.unconfirmed?
      redirect_to new_confirmation_path, alert: 'Confirm'
    elsif @user.nil? || @user.password_reset_token_expired?
      redirect_to new_password_path, alert: 'Invalid or expired token'
    end
  end

  def new

  end

  def update
    @user = User.find_by(password_reset_token: params[:password_reset_token])
    if @user
      if @user.unconfirmed?
        redirect_to new_confirmation_path, alert: 'Confirm'
      elsif @user.password_reset_token_expired?
        redirect_to new_password_path, alert: 'Invalid or expired token'
      elsif @user.update(password_params)
        @user.regenerate_password_reset_token
        redirect_to login_path, notice: 'Signed in.'
      else
        flash.now[:alert] = @user.errors.full_messages.to_sentence
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = 'Incorrect'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
