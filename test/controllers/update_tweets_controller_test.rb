require "test_helper"

class UpdateTweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get tweets_update_url
    assert_response :success
  end
end
