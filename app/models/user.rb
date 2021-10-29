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

require 'open-uri'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :profile_picture, blob: { content_type: :image, size_range: 1..(5.megabytes) }
  validates_associated :friendships
  
  has_many :posts, dependent: :destroy

  has_many :sent_friend_requests,
           class_name: 'FriendRequest',
           foreign_key: :requester_id,
           dependent: :destroy

  has_many :received_friend_requests,
           class_name: 'FriendRequest',
           foreign_key: :requestee_id,
           dependent: :destroy
  
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :profile_picture

  def self.from_omniauth(auth)
    new_user = User.where(provider: auth.provider, uid: auth.uid).empty?
    omniauth_user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      if auth.info.image
        profile_picture = URI.open(auth.info.image)
        user.profile_picture.attach(io: profile_picture, filename: "image-#{Time.now.strftime('%s%L')}", content_type: profile_picture.content_type)
      end
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
    UserMailer.with(user: omniauth_user).welcome_email.deliver_later if omniauth_user.persisted? && new_user
    omniauth_user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.name = data["name"] if user.name.blank?
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
