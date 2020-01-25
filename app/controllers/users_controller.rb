class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def create
    params[:names].each do |name|
      User.create(name: name)
    end
    redirect_to users_path
  end
end
