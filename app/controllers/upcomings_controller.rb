class UpcomingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @pagy, @upcoming_tweets = pagy(current_user.upcoming_tweets_this_week)
    @grouped_tweets = @upcoming_tweets.group_by_deletion_date
  end
end
