module BillingsHelper
  def subscription_status
    if subscribed?
      "subscribed at $29/year"
    else
      "not subscribed"
    end
  end

  def subscribed?
    current_user.payment_processor.subscribed?(name: "default")
  end
end
