class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @post = Post.new
    @posts = Post.where(user_id: current_user.friends).or(Post.where(user_id: current_user.id)).includes(:user).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(:created_at)
    @comment = Comment.new
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

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
