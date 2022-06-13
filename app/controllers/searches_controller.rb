class SearchesController < ApplicationController
  before_action :authenticate_user!

  def show
    if params[:query].present?
      @pagy, @tweets = pagy(tweets)

      respond_to do |format|
        format.html
        format.turbo_stream
      end
    else
      redirect_to tweets_path
    end
  end

  private

  def tweets
    current_user.tweets.oldest_first.search_by_text(params[:query])
  end
end
