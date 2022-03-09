require "test_helper"

class TweetTest < ActiveSupport::TestCase
  setup do
    @tweet_1 = tweets(:one)
    @saved_tweet = tweets(:two)
  end

  test "#not_saved doesn't return saved tweet" do
    deletable_tweets = Tweet.not_saved
    assert_not_includes deletable_tweets, @saved_tweet
  end
end
