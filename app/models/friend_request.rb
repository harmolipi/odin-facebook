# == Schema Information
#
# Table name: friend_requests
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  requestee_id :bigint           not null
#  requester_id :bigint           not null
#
# Indexes
#
#  index_friend_requests_on_requestee_id  (requestee_id)
#  index_friend_requests_on_requester_id  (requester_id)
#
# Foreign Keys
#
#  fk_rails_...  (requestee_id => users.id)
#  fk_rails_...  (requester_id => users.id)
#
class FriendRequest < ApplicationRecord
  validates :requester, uniqueness: { scope: :requestee }
  validate :not_friends
  validate :not_self

  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'

  def accept
    requester.friends << requestee
    requestee.friends << requester
    self.destroy
  end

  def reject
    self.destroy
  end

  private

  def not_friends
    errors.add(:base, :already_friends, message: 'You are already friends') if requester.friends.include?(requestee) || requestee.friends.include?(requester)
  end

  def not_self
    errors.add(:base, :is_self, message: 'You cannot send a friend request to yourself') if requester == requestee
  end
end
