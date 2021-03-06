class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = current_user.friendships
  end

  def create
    friend_request = FriendRequest.find_by(requestee: current_user, requester: User.find(params[:requester_id]))
    friend = friend_request.requester
    if !friend_request.nil?
      friend_request.accept
      flash[:notice] = "You are now friends with #{friend.name}"
      redirect_back(fallback_location: friend_requests_path)
    else
      redirect_to current_user
    end
  end

  def destroy
    user = User.find(params[:id])
    friendships = Friendship.where(user: current_user, friend: user).or(Friendship.where(user: user, friend: current_user))
    if !friendships.nil?
      friendships.destroy_all
      redirect_back(fallback_location: friend_requests_path)
    else
      redirect_to user_path(user)
    end
  end
end
