class SetupSweepingUsersJob < ApplicationJob
  queue_as :default

  def perform
    User.enabled_sweeping.each do |user|
      QueueTweetDeletionsJob.perform_now(user)
    end
  end
end
