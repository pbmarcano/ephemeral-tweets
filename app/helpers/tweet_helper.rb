module TweetHelper
  def countdown_days(tweet)
    "#{threshold_date_diff(tweet)}d"
  end

  def delete_countdown(tweet)
    if sweeping?(tweet)
      "This tweet deletes #{delete_timeline(tweet)}"
    else
      "This tweet would delete in #{delete_timeline(tweet)}"
    end
  end

  def date_link_to(tweet)
    return link_to(
      tweet.published_at.strftime("%D"), 
      tweet.url, 
      class: "hover:underline",
      target: "_blank" 
    )
  end

  def keep_tweet(tweet)
    if tweet.saved?
      return link_to "Don't Keep",
        keep_path(tweet),
        class: "hover:underline",
        data: {
          turbo_method: :delete
        }
    else
      return link_to "Keep",
        keep_path(tweet),
        class: "hover:underline",
        data: {
          turbo_method: :patch
        }
    end
  end

  private

  def delete_timeline(tweet)
    delete_at = threshold(tweet).days.ago

    if tweet.published_at < delete_at
      return "soon"
    else
      return "in #{distance_of_time_in_words(tweet.published_at, delete_at)}"
    end
  end

  def threshold_date_diff(tweet)
    published_date = tweet.published_at
    threshold_date = threshold(tweet).days.ago
    days_until_deletion = ((published_date - threshold_date)/1.days).round
    
    # if days are in the negative, it will delete tomorrow
    if days_until_deletion < 0
      days_until_deletion = 0
    end

    return days_until_deletion
  end

  def threshold(tweet)
    @threshold ||= tweet.user.setting.time_threshold
  end

  def sweeping?(tweet)
    @sweeping ||= tweet.user.setting.sweeping
  end
end
