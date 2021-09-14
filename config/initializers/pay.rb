Rails.application.config.to_prepare do
  Pay::Subscription.include SubscriptionExtensions
end
