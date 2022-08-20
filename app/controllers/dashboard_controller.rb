class DashboardController < ApplicationController
  def index
    @users = User.long_time_all
    @books = Book.long_time_all
  end
end
