require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Creating a user' do
    it 'must have a name' do
      user = User.new(email: 'rspec@test.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_invalid
    end

    it 'must have an email address' do
      user = User.new(name: 'rspec', password: 'password', password_confirmation: 'password')
      expect(user).to be_invalid
    end

    it 'must have a password' do
      user = User.new(name: 'rspec', email: 'rspec@test.com')
      expect(user).to be_invalid
    end

    it 'must have a unique email' do
      User.create(name: 'rspec', email: 'rspec@test.com', password: 'password', password_confirmation: 'password')
      user = User.new(name: 'rspec', email: 'rspec@test.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_invalid
    end

    it 'successfully creates with all necessary attributes' do
      user = User.new(name: 'rspec', email: 'rspec@test.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid   
    end
  end
end
