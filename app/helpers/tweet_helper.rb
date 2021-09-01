module TweetHelper
  def delete_countdown(tweet)
    threshold = tweet.user.time_threshold

    x_days = distance_of_time_in_words(tweet.published_at, threshold.days.ago)

    return "deletes in #{x_days}"
  end

  def delete_now(tweet)
    return link_to "delete now", 
      tweet_path(tweet), 
      style: "color: red;", 
      method: :delete, 
      data: { 
        confirm: "Are you sure? You will be deleting this tweet off twitter forever" 
      } 
  end
end
