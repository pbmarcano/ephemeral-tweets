module SubscriptionExtensions
  extend ActiveSupport::Concern

  included do
    after_update :disable_sweeping
  end

  private

  def disable_sweeping
    if user.present?
      user.setting.disable_sweeping unless self.active?
    end
  end

  def user 
    @user ||= self.customer.owner
  end
end
