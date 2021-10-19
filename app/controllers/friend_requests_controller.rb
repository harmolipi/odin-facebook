class FriendRequestsController < ApplicationController
  def index

  end
  
  # POST /friend_requests
  def create
    @friend_request = current_user.friend_requests.new(friend_request_params)
    if @friend_request.save
      flash[:notice] = 'Friend request sent!'
      redirect_to friend_requests_path
    else
      flash[:alert] = 'Friend request failed!'
      redirect_to users_path
    end
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:friend)
  end
end
