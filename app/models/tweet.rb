class Tweet < ApplicationRecord
  belongs_to :user
  scope :oldest_first, -> { order(published_at: :asc) }

  delegate :name, to: :user
  delegate :profile_image, to: :user
  delegate :username, to: :user

  after_create_commit do
    broadcast_prepend_later_to user, :tweets, target: "tweets"
  end

  after_destroy_commit do
    broadcast_remove_to user, :tweets
  end
end
