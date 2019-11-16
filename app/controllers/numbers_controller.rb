class NumbersController < ApplicationController
  def index
    @locales = %i[en ja de it sv ruby]
    @number = 10000.5
  end
end
