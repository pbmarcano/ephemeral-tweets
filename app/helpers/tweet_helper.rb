module TweetHelper
  def delete_countdown(tweet)
    if sweeping?(tweet)
      return "deletes in #{delete_timeline(tweet)}"
    else
      return "would delete in #{delete_timeline(tweet)}"
    end
  end

  def date_link_to(tweet)
    return link_to(
      tweet.published_at.strftime("%b %d, %Y"), 
      tweet.url, 
      class: "text-sm hover:underline",
      target: "_blank" 
    )
  end

  def delete_now_link(tweet)
    return link_to delete_countdown(tweet), 
      tweet_path(tweet), 
      class: "text-red-500 hover:underline",
      method: :delete, 
      data: { 
        confirm: "Want to delete this tweet now? This is irreversible." 
      } 
  end

  def save_tweet(tweet)
    if tweet.saved?
      return link_to "Unsave",
        tweet_saves_path(tweet),
        class: "",
        method: :delete
    else
      return link_to "Save",
        tweet_saves_path(tweet),
        class: "",
        method: :post
    end
  end

  private

  def delete_timeline(tweet)
    delete_at = threshold(tweet).days.ago

    if tweet.published_at < delete_at
      return "1 day"
    else
      return distance_of_time_in_words(tweet.published_at, delete_at)
    end
  end

  def threshold(tweet)
    @threshold ||= user_settings(tweet).time_threshold
  end

  def sweeping?(tweet)
    @sweeping ||= user_settings(tweet).sweeping
  end

  def user_settings(tweet)
    @user_settings ||= tweet.user.setting
  end
end
