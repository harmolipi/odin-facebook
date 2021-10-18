require 'rails_helper'
require 'faker'

RSpec.describe Post, type: :model do
  context 'creating a post' do
    before do
      @user = User.new(name: Faker::Name.name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
    end

    it 'requires text in the body' do
      post = @user.posts.new
      expect(post.valid?).to be false
    end

    it 'requires a user' do
      post = Post.new(body: Faker::Lorem.paragraph)
      expect(post.valid?).to be false
    end

    it 'creates successfully with user and text in the body' do
      post = @user.posts.new(body: 'Hello world')
      expect(post.valid?).to be true
    end
  end
end
