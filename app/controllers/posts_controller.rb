class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @post = Post.new
    @posts = Post.all.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
