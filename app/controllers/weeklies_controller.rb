class WeekliesController < ApplicationController
  before_action :authenticate_user!

  def show
    @weekly_review = WeeklyReview.new(current_user)
  end
end
