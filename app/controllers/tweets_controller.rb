class TweetsController < ApplicationController
  before_action :set_tweet, except: [:fetch, :sweep]
  
  def show
  end

  def destroy
    DeleteTweetJob.perform_now(@tweet)
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream { head :no_content }
    end
  end

  def fetch
    FetchTweetsJob.perform_now(current_user)
    respond_to do |format|
      format.html { redirect_to dashboard_path } 
      format.turbo_stream { head :no_content }
    end
  end

  def sweep
    QueueTweetDeletionsJob.perform_now(current_user)
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream { head :no_content }
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
