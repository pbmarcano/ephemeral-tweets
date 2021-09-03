class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @tweets = current_user.tweets.oldest_first
  end
end
