class UploadArchivesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def create
    UploadArchiveService.new.create_tweets(params[:archive], current_user)
    redirect_to tweets_path
  end
end
