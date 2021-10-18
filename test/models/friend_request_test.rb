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
require "test_helper"

class FriendRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
