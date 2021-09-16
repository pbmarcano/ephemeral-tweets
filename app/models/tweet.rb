class Tweet < ApplicationRecord
  belongs_to :user
  scope :oldest_first, -> { order(published_at: :asc) }

  after_create_commit do
    broadcast_prepend_later_to user, :tweets, target: "tweets"
  end
end
