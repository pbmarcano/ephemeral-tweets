class DeleteTweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    @tweet = tweet

    delete_from_twitter
    @tweet.destroy
  end

  private

  def delete_from_twitter
    client.destroy_status(@tweet.tweet_id)
  rescue Twitter::Error::NotFound # Tweet was deleted elsewhere
    return nil
  rescue Twitter::Error::Forbidden # Retweeted thing is blocked or hidden
    return nil
  end

  def client
    @client ||= @tweet.user.twitter
  end
end
