require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do
  context 'Creating a user' do
    it 'must have a name' do
      expect { User.create!(email: Faker::Internet.email, password: 'password', password_confirmation: 'password') }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'must have an email address' do
      expect { User.create!(name: Faker::Name.name, password: 'password', password_confirmation: 'password') }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'must have a password' do
      expect { User.create!(name: Faker::Name.name, email: Faker::Internet.email) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'must have a unique email' do
      test_email = Faker::Internet.email
      User.create!(name: Faker::Name.name, email: test_email, password: 'password', password_confirmation: 'password')
      expect { User.create!(name: Faker::Name.name, email: test_email, password: 'password', password_confirmation: 'password') }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'successfully creates with all necessary attributes' do
      expect { User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password') }.to_not raise_error      
    end
  end
end
