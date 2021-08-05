class SetupFetchingJob < ApplicationJob
  queue_as :default

  def perform
    User.all.each do |user|
      puts "Fetching tweets for #{user.username}"
      FetchTweetsJob.perform_later(user)
    end
  end
end
