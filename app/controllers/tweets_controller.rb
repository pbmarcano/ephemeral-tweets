class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :destroy]

  def index
    @tweets = current_user.unsaved_tweets.oldest_first
    ahoy.track "visted dashboard", { user: current_user }
  end
  
  def show
  end

  def destroy
    DeleteTweetJob.perform_now(@tweet)
    respond_to do |format|
      format.html { redirect_to tweets_path }
      format.turbo_stream
    end
  end

  def saved
    @tweets = current_user.saved_tweets.oldest_first
  end

  # collection for dev
  def fetch
    if Rails.env.development?
      FetchTweetsJob.perform_now(current_user)
      respond_to do |format|
        format.html { redirect_to tweets_path } 
        format.turbo_stream { head :no_content }
      end
    end
  end

  def sweep
    if Rails.env.development?
      QueueTweetDeletionsJob.perform_now(current_user)
      respond_to do |format|
        format.html { redirect_to tweets_path }
        format.turbo_stream { head :no_content }
      end
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
