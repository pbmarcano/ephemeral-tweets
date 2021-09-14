module SubscriptionExtensions
  extend ActiveSupport::Concern

  included do
    after_update :disable_sweeping
  end

  private

  def disable_sweeping
    self.customer.owner.setting.disable_sweeping unless self.active?
  end
end
