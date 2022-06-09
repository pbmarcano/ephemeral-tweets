# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  connect_to_twitter :boolean          default(TRUE)
#  email              :string           default(""), not null
#  first_name         :string
#  last_name          :string
#  name               :string
#  profile_image      :string
#  provider           :string
#  secret             :string
#  token              :string
#  uid                :string
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class User < ApplicationRecord
  include Trial
  include TwitterClient
  include UpcomingTweets
  pay_customer

  has_one  :setting, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :visits, class_name: "Ahoy::Visit"

  after_create do
    Setting.create(user: self)
    FetchTweetsJob.perform_later(self)
    set_payment_processor :stripe
  end

  before_destroy do
    TwitterUnauthorizedCampaign.remove(self)
  end

  scope :connected_to_twitter, -> { where(connect_to_twitter: true) }
  scope :enabled_sweeping, -> { joins(:setting).where(setting: { sweeping: true }) }
  scope :receive_upcoming_notifications, -> { 
    joins(:setting)
      .where(setting: { upcoming_notification: true })
      .where(setting: { sweeping: true })
      .has_email 
  }
  scope :has_email, -> { where.not(email: "") }

  delegate :time_threshold, to: :setting
  delegate :sweeping?, to: :setting

  def self.find_or_create_from_auth_hash(hash)
    user = find_or_create_by(provider: hash[:provider], uid: hash[:uid])

    user.update(
      name: hash.info.name,
      username: hash.info.nickname,
      email: hash.info.email,
      profile_image: hash.info.image,
      token: hash.credentials.token,
      secret: hash.credentials.secret,
      connect_to_twitter: true
    )

    TwitterUnauthorizedCampaign.remove(user)

    return user
  end

  def actively_subscribed?
    @actively_subscribed ||= payment_processor.subscriptions.active.present?
  end

  def billing_portal
    actively_subscribed? ? payment_processor.billing_portal : nil
  end
end
