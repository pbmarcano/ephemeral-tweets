class ApplicationMailer < ActionMailer::Base
  rescue_from Postmark::InactiveRecipientError, with: :log_bad_email_error

  default from: ActionMailer::Base.email_address_with_name("peter@tweetsweeper.app", "Pete via Tweet Sweeper")
  layout 'mailer'

  def log_bad_email_error(error)
    ErrorMailer.with(error: error).bad_user_email.deliver_later
    Rails.logger.error("ActionMailer error: #{error}")
  end
end
