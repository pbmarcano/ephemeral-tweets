Rails.application.config.to_prepare do
  Pay::Subscription.include SubscriptionExtensions
end

Pay.setup do |config|
  config.support_email = "peter@tweetsweeper.app"
end
