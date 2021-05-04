class DashboardController < ApplicationController
  def show
    @tweets = current_user&.timeline
  end
end
