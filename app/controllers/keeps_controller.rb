class KeepsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:update, :destroy]

  def index
    @tweets = current_user.saved_tweets.oldest_first
  end

  def update
    @tweet.update(saved_at: DateTime.now)

    respond_to do |format|
      format.html { redirect_to tweets_path }
      format.turbo_stream
    end
  end

  def destroy
    @tweet.update(saved_at: nil)

    respond_to do |format|
      format.html { redirect_to keeps_path }
      format.turbo_stream
    end
  end

  private

  def set_tweet
    @tweet = current_user.tweets.find(params[:id])
  end
end
