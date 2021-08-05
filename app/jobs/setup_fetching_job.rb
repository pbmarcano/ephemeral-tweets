class SetupFetchingJob < ApplicationJob
  queue_as :default

  def perform
    User.all.each do |user|
      FetchTweetsJob.perform_later(user)
    end
  end
end
