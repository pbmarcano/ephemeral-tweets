class UpcomingReview
  attr_reader :user

  def initialize(user)
    @user = user
  end

  delegate :time_threshold, to: :user

  def tweets_deleting_tomorrow?
    grouped_tweets_this_week[true].present?
  end

  def remaining_tweets?
    grouped_tweets_this_week[false].present?
  end

  def tomorrows_tweets
    grouped_tweets_this_week[true]
  end

  def remaining_tweets
    grouped_tweets_this_week[false].group_by{ |t| t.published_at.to_date }
  end

  # group this weeks tweets by everything getting deleted tomorrow, and
  # each day after.
  #
  # tomorrow's tweets return under [true]
  # the rest of the dates are grouped after [false]
  def grouped_tweets_this_week
    tweets_this_week.group_by{ |t| t.published_at.to_date == tomorrows_deletion_date } 
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

  def stop_date
    time_threshold.days.ago + 7.days
  end

  def tomorrows_deletion_date
    (time_threshold.days.ago + 1.days).to_date
  end
end
