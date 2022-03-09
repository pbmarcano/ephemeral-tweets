class TweetsController < ApplicationController
  before_action :authenticate_user!
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

  # collection for dev
  def fetch
    if Rails.env.development?
      FetchTweetsJob.perform_now(current_user)
      respond_to do |format|
        format.html { redirect_to dashboard_path } 
        format.turbo_stream { head :no_content }
      end
    end
  end

  def sweep
    if Rails.env.development?
      QueueTweetDeletionsJob.perform_now(current_user)
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.turbo_stream { head :no_content }
      end
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
