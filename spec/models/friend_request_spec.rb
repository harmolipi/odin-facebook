require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  let(:user1) { User.new(id: 1, name: 'Test Man', email: 'rspec@test.com', password: 'password', password_confirmation: 'password') }
  let(:user2) { User.new(id: 2, name: 'Test Two', email: 'rspec2@test.com', password: 'password', password_confirmation: 'password') }
  let!(:friend_request_1) { FriendRequest.create(requester: user1, requestee: user2) }
  
  context "friendship doesn't exist" do
    context 'friend_request already exists' do
      it 'should not be valid' do
        friend_request_2 = FriendRequest.new(requester: user1, requestee: user2)
        expect(friend_request_2).to be_invalid
      end
    end

    context 'friend_request does not exist' do
      it 'should be valid' do
        friend_request_2 = FriendRequest.new(requester: user2, requestee: user1)
        expect(friend_request_2).to be_valid
      end
    end
  end

  context 'friendship exists' do
    let!(:friendship) { Friendship.create(user: user1, friend: user2) }

    it 'should not be valid' do
      friend_request = FriendRequest.new(requester: user1, requestee: user2)
      expect(friend_request).to be_invalid
    end
  end
end
