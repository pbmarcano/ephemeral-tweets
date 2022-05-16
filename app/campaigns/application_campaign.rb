class ApplicationCampaign < Heya::Campaigns::Base
  rescue_from Postmark::InactiveRecipientError, with: :log_bad_email_error

  segment { |u| u.email.present? }
  default from: ActionMailer::Base.email_address_with_name("peter@tweetsweeper.app", "Pete via Tweet Sweeper"), bcc: "peter@tweetsweeper.app"

  def log_bad_email_error(error)
    ErrorMailer.with(error: error).bad_user_email.deliver_later
    Rails.logger.error("ActionMailer error: #{error}")
  end
end
