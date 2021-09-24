# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  provider      :string
#  uid           :string
#  username      :string
#  token         :string
#  secret        :string
#  profile_image :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class User < ApplicationRecord
  include TwitterClient

  pay_customer

  has_many :visits, class_name: "Ahoy::Visit"

  has_one  :setting, dependent: :destroy
  has_many :tweets, dependent: :destroy

  after_create do
    Setting.create(user: self)
    FetchTweetsJob.perform_later(self)
    set_payment_processor :stripe
  end

  scope :enabled_sweeping, -> { joins(:setting).where(setting: { sweeping: true }) }

  delegate :time_threshold, to: :setting
  delegate :sweeping?, to: :setting

  def self.find_or_create_from_auth_hash(hash)
    user = find_or_create_by(provider: hash[:provider], uid: hash[:uid])

    user.update(
      username: hash.info.nickname,
      email: hash.info.email,
      profile_image: hash.info.image,
      token: hash.credentials.token,
      secret: hash.credentials.secret
    )

    return user
  end

  def tweets_ready_for_deletion
    tweets.where(published_at: ..threshold_date)
  end

  def timeline
    twitter.user_timeline(id: uid)
  end

  def actively_subscribed?
    payment_processor.subscriptions.active.present?
  end

  def billing_portal
    if actively_subscribed?
      payment_processor.billing_portal
    else
      nil
    end
  end

  private

  def threshold_date
    Time.now.utc - time_threshold.days
  end
end
