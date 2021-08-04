class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.bigint :tweet_id, null: false, index: true
      t.datetime :published_at, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
