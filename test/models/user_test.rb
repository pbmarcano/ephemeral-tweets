# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  provider      :string
#  uid           :string
#  username      :string
#  token         :string
#  secret        :string
#  profile_image :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "scoped users who've enabled sweeping" do
    active_users = User.enabled_sweeping
    user2 = users(:two)

    assert active_users.exclude?(user2)
  end
end
