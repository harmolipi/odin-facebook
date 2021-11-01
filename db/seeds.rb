# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'

User.destroy_all
Faker::UniqueGenerator.clear

User.create(name: Faker::Name.unique.name, email: 'test@test.com', password: '123456', password_confirmation: '123456')
User.create(name: Faker::Name.unique.name, email: 'test2@test.com', password: '123456', password_confirmation: '123456')

User.all.each do |user|
  file = URI.open("https://res.cloudinary.com/dhvsjipc0/image/upload/v1635780235/assets/smiley_profile_picture.jpg") 
  user.profile_picture.attach(io: file, filename: 'default_profile_picture.jpg')
end
