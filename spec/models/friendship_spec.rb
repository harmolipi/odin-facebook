require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { User.create!(name: 'rspec', email: 'rspec@test.com', password: 'password', password_confirmation: 'password') }
  let(:friend) { User.create(name: 'rspec friend', email: 'rspec2@test.com', password: 'password', password_confirmation: 'password') }

  context 'friendship already exists' do
    it 'fails to create friendship' do
      user.friendships.create(friend: friend)
      friendship = user.friendships.new(friend: friend)
      expect(friendship).to be_invalid
    end
  end

  context 'friendship does not exist' do
    context 'user and friend are the same' do
      it 'fails to create friendship' do
        friendship = user.friendships.new(friend: user)
        expect(friendship).to be_invalid
      end
    end

    context 'user and friend are different' do
      it 'creates friendship' do
        friendship = user.friendships.new(friend: friend)
        expect(friendship).to be_valid
      end
    end
  end
end
