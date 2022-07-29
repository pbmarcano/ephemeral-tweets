class UploadArchivesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def create
    current_user.archive.attach(params[:archive])

    UploadArchiveService.new.create_tweets(current_user)
    redirect_to tweets_path
  end
end
