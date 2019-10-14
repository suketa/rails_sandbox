class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])
    @publishers = Publisher.with_author(params[:id])
  end
end
