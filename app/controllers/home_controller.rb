class HomeController < ApplicationController
  def index
    @user_agent = request.user_agent
  end
end
