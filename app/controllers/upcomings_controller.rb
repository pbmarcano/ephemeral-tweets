class UpcomingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @upcoming_review = UpcomingReview.new(current_user)
  end
end
