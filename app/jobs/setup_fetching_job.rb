class SetupFetchingJob < ApplicationJob
  queue_as :default

  def perform
    User.connected_to_twitter.each do |user|
      puts "Fetching tweets for #{user.username}"
      FetchTweetsJob.perform_later(user)
    end
  end
end
