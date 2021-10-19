# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_friendships_on_friend_id  (friend_id)
#  index_friendships_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (friend_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
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
