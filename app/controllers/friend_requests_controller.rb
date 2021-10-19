class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friend_requests = current_user.received_friend_requests
  end
  
  # POST /friend_requests
  def create
    friend_request = current_user.sent_friend_requests.create(friend_request_params)
    if friend_request.save
      flash[:notice] = 'Friend request sent!'
      redirect_to friend_request.requestee
    else
      flash[:alert] = 'Friend request failed!'
      redirect_to user_path(friend_request_params[:requestee_id])
    end
  end

  # DELETE /friend_requests/1
  def destroy
    friend_request = FriendRequest.find(params[:id])
    friend_request.destroy
    flash[:notice] = 'Friend request deleted!'
    redirect_to friend_request.requestee
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:requester_id, :requestee_id)
  end
end
