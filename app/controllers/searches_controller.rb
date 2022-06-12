class SearchesController < ApplicationController
  before_action :authenticate_user!

  def show
    if params[:query].present?
      @tweets = tweets
    else
      redirect_to tweets_path
    end
  end

  private

  def tweets
    current_user.tweets.oldest_first.search_by_text(params[:query])
  end
end
