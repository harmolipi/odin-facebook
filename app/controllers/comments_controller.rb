class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(comment_params[:post_id])
    comment = current_user.comments.new(comment_params)
    if comment.save
      flash[:notice] = 'Comment was successfully created'
    else
      flash[:alert] = 'Comment was not successful'
    end
    redirect_to post_path(post)
  end

  private

  def comment_params
    params.require(:comment).permit(:id, :body, :post_id, :user_id)
  end
end
