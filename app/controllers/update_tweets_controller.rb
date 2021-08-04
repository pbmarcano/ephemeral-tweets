class UpdateTweetsController < ApplicationController
  def show
    FetchTweetsJob.perform_now(current_user) if current_user.present?
    redirect_to root_path
  end
end
