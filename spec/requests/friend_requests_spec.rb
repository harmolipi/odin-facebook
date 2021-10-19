require 'rails_helper'

RSpec.describe "FriendRequests", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get friend_requests_path
      expect(response).to be_successful
    end
  end
end
