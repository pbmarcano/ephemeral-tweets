class AddFullTextAndUrlToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :full_text, :string
    add_column :tweets, :url, :string
  end
end
