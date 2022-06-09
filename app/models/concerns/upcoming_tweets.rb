module UpcomingTweets
  extend ActiveSupport::Concern

  def upcoming_tweets_this_week
    self.
      tweets.
      oldest_first.
      not_saved.
      where(published_at: ..stop_date)
  end

  private

  def stop_date
    time_threshold.days.ago + 7.days
  end
end
