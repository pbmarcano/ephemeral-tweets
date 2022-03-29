class AddEngagementToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :reply_count, :integer, default: 0
    add_column :tweets, :retweet_count, :integer, default: 0
    add_column :tweets, :favorite_count, :integer, default: 0
  end
end
