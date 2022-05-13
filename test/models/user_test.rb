# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  connect_to_twitter :boolean          default(TRUE)
#  email              :string           default(""), not null
#  first_name         :string
#  last_name          :string
#  name               :string
#  profile_image      :string
#  provider           :string
#  secret             :string
#  token              :string
#  uid                :string
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
  end

  test "scoped users who've enabled sweeping" do
    active_users = User.enabled_sweeping

    assert active_users.include?(@user1)
    assert active_users.exclude?(@user2)
  end

  test "scoped users who've enabled upcoming emails" do
    notified_users = User.receive_upcoming_notifications

    assert notified_users.include?(@user1)
    assert notified_users.exclude?(@user2)
  end

  test "filter out users who are unauthorized on twitter" do
    connected_users = User.connected_to_twitter

    assert connected_users.include?(@user1)
    assert connected_users.exclude?(@user2)
  end

  test "users without email addresses don't get upcoming emails" do
    @user1.update(email: "")
    notified_users = User.receive_upcoming_notifications

    assert notified_users.exclude?(@user1)
  end
end
