# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  biography              :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
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
