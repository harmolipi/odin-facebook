require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user1) { User.create(name: 'rspec', email: 'rspec@test.com', password: 'password', password_confirmation: 'password') }
  
  describe 'GET /show' do
    it 'returns http success' do
      sign_in user1
      get user_path(user1)
      expect(response).to be_successful
    end
  end
end
