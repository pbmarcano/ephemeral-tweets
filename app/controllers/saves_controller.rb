class SavesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    @tweet.update(saved_at: DateTime.now)

    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  def destroy
    @tweet.update(saved_at: nil)

    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
