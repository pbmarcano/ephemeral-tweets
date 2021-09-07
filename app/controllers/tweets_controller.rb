class TweetsController < ApplicationController
  before_action :set_tweet, only: :destroy

  def destroy
    DeleteTweetJob.perform_now(@tweet)
    redirect_to dashboard_path
  end

  def fetch
    FetchTweetsJob.perform_now(current_user)
    redirect_to dashboard_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
