class TweetDecorator
  attr_reader :tweet

  def initialize(tweet)
    @tweet = tweet
  end

  delegate :user, to: :tweet

  def date
    tweet.published_at.to_datetime.strftime("%b %d, %Y")
  end

  def full_text
    twitter_data.full_text
  end

  def url
    twitter_data.url.to_s
  end

  private

  def twitter_data
    @twitter_data ||= user.twitter.status(tweet.tweet_id)
  end
end
