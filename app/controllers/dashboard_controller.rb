class DashboardController < ApplicationController
  def index
    @users = users
    @books = books
  end

  private

  def users
    sleep 5
    User.all
  end

  def books
    sleep 5
    Book.all
  end
end
