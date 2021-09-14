class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    @checkout_session = current_user.payment_processor.checkout(
      mode: "subscription",
      line_items: "price_1JZKWWGRMpXpIAvQkbbtgQnE",
      success_url: dashboard_url,
      cancel_url: dashboard_url
    )
  end
end
