class UploadArchiveJob < ApplicationJob
  queue_as :default

  def perform(user)
    UploadArchiveService.new.create_tweets(user)
  rescue NoMethodError
    UploadArchiveMailer.bad_file(user: user).deliver_now
  end
end
