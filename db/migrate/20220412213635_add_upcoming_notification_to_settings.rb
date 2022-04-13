class AddUpcomingNotificationToSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :settings, :upcoming_notification, :boolean, default: false
  end
end
