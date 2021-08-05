class SetupSweepingJob < ApplicationJob
  queue_as :default

  def perform
    User.enabled_sweeping.each do |user|
      QueueTweetDeletionsJob.perform_later(user)
    end
  end
end
