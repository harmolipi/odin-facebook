class FriendshipsController < ApplicationController
  def create
    friend_request = FriendRequest.where(requestee: current_user, requester: User.find(params[:requester_id])).first
    if !friend_request.nil?
      friend_request.accept
      redirect_to user_path(friend_request.requester)
    else
      redirect_to user_path(current_user)
    end
  end
end
