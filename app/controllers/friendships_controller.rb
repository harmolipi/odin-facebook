class FriendshipsController < ApplicationController
  def index
    @friendships = current_user.friendships
  end

  def create
    friend_request = FriendRequest.where(requestee: current_user, requester: User.find(params[:requester_id])).first
    friend = friend_request.requester
    if !friend_request.nil?
      friend_request.accept
      flash[:notice] = "You are now friends with #{friend.name}"
      redirect_to friend_requests_path
    else
      redirect_to current_user
    end
  end

  def destroy
    user = User.find(params[:id])
    friendships = Friendship.where(user: current_user, friend: user).or(Friendship.where(user: user, friend: current_user))
    if !friendships.nil?
      friendships.destroy_all
      redirect_to user_path(user)
    else
      redirect_to user_path(user)
    end
  end
end
