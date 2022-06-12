# == Schema Information
#
# Table name: tweets
#
#  id             :bigint           not null, primary key
#  favorite_count :integer          default(0)
#  full_text      :string
#  published_at   :datetime         not null
#  reply_count    :integer          default(0)
#  retweet_count  :integer          default(0)
#  saved_at       :datetime
#  url            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  tweet_id       :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_tweets_on_tweet_id  (tweet_id)
#  index_tweets_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Tweet < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  scope :oldest_first, -> { order(published_at: :asc) }
  scope :not_saved, -> { where(saved_at: nil) }
  scope :saved, -> { where.not(saved_at: nil) }
  scope :group_by_deletion_date, -> { group_by{ |t| days_until_deletion(t) } }

  delegate :name, to: :user
  delegate :profile_image, to: :user
  delegate :username, to: :user
  delegate :time_threshold, to: :user

  pg_search_scope :search_by_text, against: :full_text

  after_create_commit do
    broadcast_prepend_later_to user, :tweets, target: "tweets"
  end

  def saved?
    saved_at.present?
  end

  private

  def self.days_until_deletion(tweet)
    published_date = tweet.published_at
    threshold_date = tweet.time_threshold.days.ago
    days_until_deletion = ((published_date - threshold_date)/1.days).round
    
    # if days are in the negative, it will delete tomorrow
    if days_until_deletion < 0
      days_until_deletion = 0
    end

    return days_until_deletion
  end
end
