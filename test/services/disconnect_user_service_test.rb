require "test_helper"

class DisconnectUserServiceTest < ActiveSupport::TestCase
  setup do
    @subscribed_user = users(:one)
    @not_subscribed_user = users(:two)
  end

  test "subscribed user deleted their twitter account" do
    skip # don't now to test api programatically

    DisconnectUserService.new(user: @subscribed_user).disconnect
    # assert that we email ErrorMailer.no_twitter_user
  end

  test "not subscribed user deleted their twitter account" do
    skip

    DisconnectUserService.new(user: @not_subscribed_user).disconnect
    assert @not_subscribed_user.destroyed?
  end

  test "subscribed user disconnects api keys" do
    skip

    DisconnectUserService.new(user: @subscribed_user).disconnect
    # assert that we add user to unauthorized campaign
  end

  test "not subscribed user disconnects api keys" do
    skip

    DisconnectUserService.new(user: @not_subscribed_user).disconnect
    assert @not_subscribed_user.destroyed?
  end
end
