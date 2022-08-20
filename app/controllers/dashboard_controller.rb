class DashboardController < ApplicationController
  def index
    @index_at = Time.zone.now
    @users = User.long_time_all
    @books = Book.long_time_all
  end
end
