class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription

  def update
    @subscription.resume

    redirect_to account_path
  end

  def destroy
    @subscription.cancel

    redirect_to account_path
  end

  private
  
  def set_subscription
    @subscription = current_user.payment_processor.subscription
  end
end
