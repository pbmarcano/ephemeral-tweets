class UpcomingReview
  attr_reader :user

  def initialize(user)
    @user = user
  end

  delegate :time_threshold, to: :user

  def grouped_tweets_this_week
    tweets_this_week.group_by{ |t| days_until_deletion(t) } 
  end

  # tweets this week grabs all tweets that will be deleted this week
  def tweets_this_week
    @tweets_this_week ||= user.
      tweets.
      oldest_first.
      not_saved.
      where(published_at: ..stop_date)
  end

  private

  # get the difference between when a tweet was published and 
  # when it should be deleted by, in days.
  def days_until_deletion(tweet)
    published_date = tweet.published_at
    threshold_date = time_threshold.days.ago
    days_until_deletion = ((published_date - threshold_date)/1.days).round
    
    # if days are in the negative, it will delete tomorrow
    if days_until_deletion < 0
      days_until_deletion = 0
    end

    return days_until_deletion
  end

  def stop_date
    time_threshold.days.ago + 7.days
  end
end
