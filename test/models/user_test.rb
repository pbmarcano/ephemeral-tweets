# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  email         :string           default(""), not null
#  first_name    :string
#  last_name     :string
#  name          :string
#  profile_image :string
#  provider      :string
#  secret        :string
#  token         :string
#  uid           :string
#  username      :string
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
