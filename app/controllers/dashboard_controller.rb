class DashboardController < ApplicationController
  def index
    @index_at = Time.zone.now
  end

  def users
    @users = User.long_time_all
  end

  def books
    @books = Book.long_time_all
  end
end
