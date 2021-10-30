class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.includes(:friends).order(:name)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:user, :likes, :comments).with_attached_picture.order(created_at: :desc)
    @post = Post.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    user_params[:biography].strip!
    if @user.update(user_params)
      @user.profile_picture.attach(user_params[:profile_picture]) unless user_params[:profile_picture].nil?
      flash[:notice] = "User information updated"
      redirect_to @user
    else
      flash[:error] = "Invalid user information"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:biography, :profile_picture)
  end
end
