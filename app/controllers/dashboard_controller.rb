class DashboardController < ApplicationController
  def index
    @books = Book.all
    @users = User.all.to_a
    @users_in_library = User.all_in_library
  end
end
