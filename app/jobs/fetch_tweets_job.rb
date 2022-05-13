class FetchTweetsJob < ApplicationJob
  queue_as :default

  # retry on errors... see if this stops them from getting logged
  retry_on HTTP::ConnectionError
  retry_on ActiveJob::DeserializationError
  retry_on Twitter::Error::InternalServerError

  rescue_from Twitter::Error::Unauthorized, with: :reauthorize_user 

  def perform(user)
    fetched_tweets_by(user).each do |tweet|
      make_tweet(tweet, user)
    end
  end

  private

  def make_tweet(tweet, user)
    t = Tweet.find_or_initialize_by(tweet_id: tweet.id, user: user)

    t.assign_attributes(
      published_at: tweet.created_at.to_datetime,
      full_text: tweet.full_text,
      reply_count:  tweet.reply_count? ? tweet.reply_count : 0,
      retweet_count: tweet.retweet_count? ? tweet.retweet_count : 0,
      favorite_count: tweet.favorite_count? ? tweet.favorite_count : 0,
      url: tweet.url.to_s
    )

    t.save
  end

  def fetched_tweets_by(user)
    collect_with_max_id do |max_id|
      options = {count: 200, include_rts: true, id: user.uid}
      options[:max_id] = max_id unless max_id.nil?
      user.twitter.user_timeline(options)
    end
  end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    collection += response

    if response.empty?
      collection.flatten 
    else
      collect_with_max_id(collection, response.last.id - 1, &block)
    end
  end

  def reauthorize_user(e)
    user = arguments[0]
    petes_account = User.find_by(uid: "40290771")

    # Freenze connecting to twitter until fixed
    user.update(connect_to_twitter: false)

    # Should throw Twitter::Error::NotFound if user doesn't exist
    petes_account.twitter.user(user.uid.to_i) 

    # Send user twitter emails to log into tweet sweeper to reconnect
    TwitterUnauthorizedCampaign.add(user, restart: true)
  rescue Twitter::Error::NotFound
    # send an email saying it looks like your deleted your twitter account, 
    # is it temporary or do you also need to cancel Tweet Sweeper?

    ErrorMailer.with(user: user).no_twitter_user.deliver_later
  end
end
