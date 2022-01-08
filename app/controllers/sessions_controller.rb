class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[create new]

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if @user.unconfirmed?
        redirect_to new_confirmation_path, alert: 'incorrect email or password'
      elsif @user.authenticate(params[:user][:password])
        login @user
        redirect_to root_path, notice: 'signed in'
      else
        flash.now[:alert] = 'incorrect email or password'
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = 'incorrect email or password'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'signed out'
  end

  def new
  end
end
