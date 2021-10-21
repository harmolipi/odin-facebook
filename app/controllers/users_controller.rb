class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User information updated"
      redirect_to @user
    else
      flash[:error] = "Invalid user information"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:biography)
  end
end
