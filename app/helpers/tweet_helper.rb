module TweetHelper
  def delete_countdown(tweet)
    return "deletes in #{delete_timeline(tweet)}"
  end

  def date_link_to(tweet)
    return link_to(
      tweet.published_at.strftime("%b %d, %Y"), 
      tweet.url, 
      class: "text-blue-600 underline",
      target: "_blank" 
    )
  end

  def delete_now_link(tweet)
    return link_to "delete now", 
      tweet_path(tweet), 
      class: "text-red-500",
      method: :delete, 
      data: { 
        confirm: "Are you sure? You will be deleting this tweet off twitter forever" 
      } 
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
    @threshold ||= tweet.user.time_threshold
  end
end
