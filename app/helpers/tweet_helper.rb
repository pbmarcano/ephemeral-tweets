module TweetHelper
  def tweet_date(tweet)
    tweet.published_at.to_datetime.strftime("%b %d, %Y")
  end
end
