class TweetsController < ApplicationController
  before_action :set_tweet, only: :destroy

  def destroy
    DeleteTweetJob.perform_now(@tweet)
    redirect_to root_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
