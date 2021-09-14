class BillingsController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.actively_subscribed?
      @portal_session = current_user.billing_portal
    end
  end
end
