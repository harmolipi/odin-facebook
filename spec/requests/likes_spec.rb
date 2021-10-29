require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { User.create!(name: 'rspec', email: 'rspec@test.com', password: 'password', password_confirmation: 'password') }
  let(:post) { user.posts.create!(body: 'rspec test!', id: '1') }
  
  describe "POST /create" do
    let (:post_params) do
      { post_id: post.id }
    end

    xit "returns http success" do
      post "/likes/create"
      expect(response).to have_http_status(:success)
    end

    xit 'creates a new like' do
      sign_in user
      expect { post likes_path, params: { post_id: '1' } }.to change(Like, :count).by(1)
    end
  end

  describe "DELETE /destroy" do
    xit "returns http success" do
      delete "/likes/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
