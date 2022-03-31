# == Schema Information
#
# Table name: tweets
#
#  id             :bigint           not null, primary key
#  favorite_count :integer          default(0)
#  full_text      :string
#  published_at   :datetime         not null
#  reply_count    :integer          default(0)
#  retweet_count  :integer          default(0)
#  saved_at       :datetime
#  url            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  tweet_id       :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_tweets_on_tweet_id  (tweet_id)
#  index_tweets_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
