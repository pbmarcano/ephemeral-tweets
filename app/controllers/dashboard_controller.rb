class DashboardController < ApplicationController
  def show
    db_tweets = current_user&.tweets&.oldest_first
    @tweets = db_tweets&.map { |t| TweetDecorator.new(t) }
  end
end
