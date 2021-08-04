class FetchTweetsJob < ApplicationJob
  queue_as :default

  def perform(user)
    GetTweetsService.call(user).each do |tweet|
      Tweet.find_or_create_by(
        tweet_id: tweet.id, 
        user: user, 
        published_at: tweet.created_at
      )
    end
  end
end
