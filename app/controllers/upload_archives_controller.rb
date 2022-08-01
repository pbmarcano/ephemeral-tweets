class UploadArchivesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def create
    @archive = UploadArchiveForm.new(
      user: current_user, 
      archive: params[:archive]
    )

    if @archive.save
      redirect_to tweets_path, notice: "Tweet Sweeper is loading tweets from your archive"
    else
      render :show
    end
  end

#     current_user.archive.attach(params[:archive])
#     UploadArchiveService.new.create_tweets(current_user)
#     redirect_to tweets_path
end
