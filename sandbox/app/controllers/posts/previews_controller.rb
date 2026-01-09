class Posts::PreviewsController < ApplicationController
  def create
    require "commonmarker"
    @markdown = Commonmarker.to_html(params[:body])
    render turbo_stream: turbo_stream.update("preview", @markdown)
  end
end
