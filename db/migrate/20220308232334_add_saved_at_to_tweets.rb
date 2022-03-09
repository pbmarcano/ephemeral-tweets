class AddSavedAtToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :saved_at, :datetime
  end
end
