class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    @checkout_session = current_user.payment_processor.checkout(
      mode: "subscription",
      line_items: Rails.application.credentials.dig(:stripe, :standard_product),
      success_url: tweets_url,
      cancel_url: tweets_url
    )
  end
end
