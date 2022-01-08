class ConfirmationsController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[create new]
  def create
    @user = user.find_by(email: params[:user][:email].downcase)

    if @user.present? && @user.unconfirmed?
      @user.send_confirmation_email!
      redirect_to root_path, notice: 'Check your email for confirmation instructions.'
    else
      redirect_to new_confirmation_path, alert: 'We could not find a user'
    end
  end

  def edit
    @user = user.find_by(confirmation_token: params[:confirmation_token])
    if @user.present? && @user.confirmation_token_is_valid?
      @user.confirm!
      login @user
      redirect_to root_path, notice: 'Your account has been confirmed'
    else
      redirect_to new_confirmation_path, notice: 'invalid'
    end
  end

  def new
    @user = User.new
  end
end
