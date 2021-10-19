require 'rails_helper'

RSpec.describe 'FriendRequests', type: :request do
  let(:user1) { User.create!(name: 'rspec', email: 'rspec@test.com', password: 'password', password_confirmation: 'password') }
  let(:user2) { User.create!(name: 'rspec two', email: 'rspec2@test.com', password: 'password', password_confirmation: 'password') }
  
  describe 'GET index' do
    it 'returns http success' do
      sign_in user1
      friend_request = FriendRequest.create(requester: user2, requestee: user1)
      get friend_requests_path
      expect(response.body).to include(user2.name)
      expect(response).to be_successful
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      let (:friend_request_params) do
        { friend_request:
          {
            requester_id: user1.id, requestee_id: user2.id
          }
        }
      end

      it 'creates a new friend_request and redirects to the friend requests index page' do
        sign_in user1
        expect { post friend_requests_path, params: friend_request_params }.to change(FriendRequest, :count).by(1)
        expect(response).to redirect_to(friend_requests_path)
      end
    end

    context 'with invalid attributes' do
      let (:friend_request_params) do
        { friend_request:
          {
            requester_id: user1.id, requestee_id: user1.id
          }
        }
      end

      it 'does not create a new friend_request and redirects to the friend requests index page' do
        sign_in user1
        expect { post friend_requests_path, params: friend_request_params }.to change(FriendRequest, :count).by(0)
      end
    end
  end
end
