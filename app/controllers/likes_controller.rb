class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(post_id: params[:post_id])
    if @like.save
      flash[:notice] = "Like was successful!"
      redirect_to posts_path
    else
      flash[:alert] = "There was an error liking the post."
      redirect_to posts_path
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      flash[:notice] = "Unlike was successful!"
      redirect_to posts_path
    else
      flash[:alert] = "There was an error unliking the post."
      redirect_to posts_path
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
