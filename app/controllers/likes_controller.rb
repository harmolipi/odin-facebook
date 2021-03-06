class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(post_id: params[:post_id])
    if @like.save
      redirect_back(fallback_location: posts_path)
    else
      flash[:alert] = "There was an error liking the post."
      redirect_to posts_path
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      redirect_back(fallback_location: posts_path)
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
