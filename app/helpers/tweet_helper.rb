module TweetHelper
  def tweet_date(tweet)
    tweet.created_at.to_datetime.strftime("%b %d, %Y")
  end
end
