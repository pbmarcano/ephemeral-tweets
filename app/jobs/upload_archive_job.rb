class UploadArchiveJob < ApplicationJob
  queue_as :default

  def perform(user)
    UploadArchiveService.new.create_tweets(user)
  end
end
