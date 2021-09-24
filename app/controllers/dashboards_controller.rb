class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @tweets = current_user.tweets.oldest_first
    ahoy.track "visted dashboard", { user: current_user }
  end
end
