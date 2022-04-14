module TwitterClient
  extend ActiveSupport::Concern

  def twitter
    @twitter ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret     = Rails.application.credentials.twitter[:api_secret]
      config.access_token        = token
      config.access_token_secret = secret
    end
  end

  def timeline
    twitter.user_timeline(id: uid)
  end

  def tweets_ready_for_deletion
    tweets.not_saved.where(published_at: ..threshold_date)
  end

  def has_tweets_saved?
    tweets.saved.present?
  end

  def unsaved_tweets
    tweets.not_saved
  end

  def saved_tweets
    tweets.saved
  end

  private

  def threshold_date
    Time.now.utc - time_threshold.days
  end
end
