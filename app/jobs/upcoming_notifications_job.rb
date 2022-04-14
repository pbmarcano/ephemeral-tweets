class UpcomingNotificationsJob < ApplicationJob
  queue_as :default

  def perform
    User.receive_upcoming_notifications.each do |user|
      UpcomingMailer.notify(user).deliver_later
    end
  end
end
