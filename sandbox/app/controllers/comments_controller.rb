class CommentsController < ApplicationController
  def create
    @comment = Post.find(params[:post_id]).comments.build(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_url(@comment.post_id), notice: "コメントを投稿しました" }
      end
    else
      @post = Post.find(params[:post_id])
      respond_to do |format|
        format.html { redirect_to post_url(@comment.post_id), alert: @comment.errors.full_messages.join(", ") }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
