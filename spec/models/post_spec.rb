# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'creating a post' do
    let(:user) { User.new(name: 'rspec', email: 'rspec@test.com', password: 'password', password_confirmation: 'password') }

    it 'requires text in the body' do
      post = user.posts.new
      expect(post).to be_invalid
    end

    it 'requires a user' do
      post = Post.new(body: 'Hello world')
      expect(post).to be_invalid
    end

    it 'creates successfully with user and text in the body' do
      post = user.posts.new(body: 'Hello world')
      expect(post).to be_valid
    end
  end
end
