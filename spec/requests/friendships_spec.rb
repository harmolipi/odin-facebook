require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  let(:user1) { User.create(name: 'rspec', email: 'rspec@test.com', password: 'password', password_confirmation: 'password') }
  
  describe 'GET /index' do
    it 'returns http success' do
      sign_in user1
      get friendships_path
      expect(response).to be_successful
    end
  end
end
