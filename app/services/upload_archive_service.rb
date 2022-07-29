class UploadArchiveService
  attr_reader :user

  def create_tweets(current_user)
    @user = current_user
    tweet_data = prep_tweet_data
    save_tweets(tweet_data)
  end

  private

  def save_tweets(tweet_data)
    tweet_data.each { |tweet| make_tweet(tweet) }
  end

  def make_tweet(tweet)
    t = Tweet.find_or_initialize_by(
      tweet_id: tweet["tweet"]["id"], 
      user: user
    )

    t.assign_attributes(
      published_at: tweet["tweet"]["created_at"].to_datetime,
      full_text: tweet["tweet"]["full_text"],
      retweet_count: tweet["tweet"]["retweet_count"].to_i,
      favorite_count: tweet["tweet"]["favorite_count"].to_i,
      url: "https://twitter.com/#{user.username}/status/#{tweet["tweet"]["id"]}"
    )

    t.save
  end

  def prep_tweet_data
    # put each line of tweet archive in an array
    archive_lines = user.archive.download.split("\n")
    # replace the header
    archive_lines[0].replace("[\n")
    # merge array back into one big string
    archive_data = archive_lines.join
    # return the json object of the tweets
    return JSON.parse(archive_data)
  end
end
