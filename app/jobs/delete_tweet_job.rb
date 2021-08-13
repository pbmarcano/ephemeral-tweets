class DeleteTweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    puts "DeleteTweetJob for #{tweet.tweet_id}"
    @tweet = tweet

    # begin
    delete_from_twitter
    @tweet.destroy
    # rescue StandardError => e
    #   puts e.inspect
    #   puts "Error deleting #{tweet.id}; exiting"
    #   exit
    # else
    #   puts "Deleted #{tweet.id}"
    # end
  end

  private

  def delete_from_twitter
    client.destroy_status(@tweet.tweet_id)
  rescue Twitter::Error::NotFound
    # if can't be found on twitter, delete locally
    # @tweet.destroy
    return nil
  end

  def client
    @client ||= @tweet.user.twitter
  end
end
