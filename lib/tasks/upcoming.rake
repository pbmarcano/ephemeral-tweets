namespace :upcoming do
  desc "Notify users of upcoming tweets to be deleted"
  task notify_users: :environment do
    UpcomingNotificationsJob.perform_later
  end
end
