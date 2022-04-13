class UpcomingNotificationsJob < ApplicationJob
  queue_as :default

  def perform
    User.recieves_upcoming_notification.each do |user|
      puts "Sending upcoming email to #{user.username}"
      UpcomingMailer.notify(user).deliver_later
    end
  end
end
