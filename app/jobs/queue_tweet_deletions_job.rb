class QueueTweetDeletionsJob < ApplicationJob
  queue_as :default

  def perform(user)
    puts "QueueTweetDeletionsJob for #{user.username}"
    user.tweets_ready_for_deletion.each do |tweet|
      DeleteTweetJob.perform_later(tweet)
    end
  end
end
