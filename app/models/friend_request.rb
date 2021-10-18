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
    return unless requester.friends.include?(requestee) || requestee.friends.include?(requester)
    errors.add(:base, 'You are already friends')
  end
end
