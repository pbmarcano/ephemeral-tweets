class UploadArchiveService
  def create_tweets(archive, current_user)
    tweet_data = prep_tweet_data(archive)
    save_tweets(tweet_data, current_user)
  end

  private

  def save_tweets(tweet_data, current_user)
    tweet_data.each do |tweet|
      make_tweet(tweet, current_user)
    end
  end

  def make_tweet(tweet, current_user)
    t = Tweet.find_or_initialize_by(
      tweet_id: tweet["tweet"]["id"], 
      user: current_user
    )

    t.assign_attributes(
      published_at: tweet["tweet"]["created_at"].to_datetime,
      full_text: tweet["tweet"]["full_text"],
      retweet_count: tweet["tweet"]["retweet_count"].to_i,
      favorite_count: tweet["tweet"]["favorite_count"].to_i,
      url: "https://twitter.com/#{current_user.username}/status/#{tweet["tweet"]["id"]}"
    )

    t.save
  end

  def prep_tweet_data(archive)
    # put each line of tweet archive in an array
    archive_lines = File.open(archive).readlines
    # replace the header
    archive_lines[0].replace("[\n")
    # merge array back into one big string
    archive_data = archive_lines.join
    # return the json object of the tweets
    return JSON.parse(archive_data)
  end
end
