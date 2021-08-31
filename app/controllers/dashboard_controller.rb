class DashboardController < ApplicationController
  def show
    @tweets = current_user&.tweets&.oldest_first
  end
end
