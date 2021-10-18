require 'rails_helper'
require 'faker'

RSpec.describe Friendship, type: :model do
  before do
    @user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
    @friend = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
  end

  context 'friendship already exists' do
    it 'fails to create friendship' do
      @user.friendships.create(friend: @friend)
      friendship = @user.friendships.new(friend: @friend)
      expect(friendship).to_not be_valid
    end
  end

  context 'friendship does not exist' do
    context 'user and friend are the same' do
      it 'fails to create friendship' do
        friendship = @user.friendships.new(friend: @user)
        expect(friendship).to_not be_valid
      end
    end

    context 'user and friend are different' do
      it 'creates friendship' do
        friendship = @user.friendships.new(friend: @friend)
        expect(friendship).to be_valid
      end
    end
  end
end
