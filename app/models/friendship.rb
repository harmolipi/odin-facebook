# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_friendships_on_friend_id  (friend_id)
#  index_friendships_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (friend_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Friendship < ApplicationRecord
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :not_self

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

  def not_self
    errors.add(:friend, 'can not be the same as user') if user == friend
  end
end
