module BillingsHelper
  def subscription_status
    if current_user.actively_subscribed?
      if current_user.grace_period?
        "Auto-renew is off. Active until #{subscription_end}."
      elsif current_user.active?
        "Subscribed at $29/year."
      elsif current_user.cancelled?
        "Subscription cancelled."
      end
    else
      "Not subscribed."
    end 
  end

  def manage_subscription_link
    portal_url = current_user.billing_portal.url

    link_to("Manage Payment Info", portal_url, class: "text-sky-500 underline")
  end

  private

  def subscription_end
    current_user.payment_processor.subscription.ends_at.to_date.to_s(:long)
  end
end
