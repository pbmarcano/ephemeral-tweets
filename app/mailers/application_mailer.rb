class ApplicationMailer < ActionMailer::Base
  rescue_from Postmark::InactiveRecipientError, with: :log_error

  default from: ActionMailer::Base.email_address_with_name("peter@tweetsweeper.app", "Pete from Tweet Sweeper")
  layout 'mailer'

  private

  def log_error(error)
    ErrorMailer.with(error: error).bad_user_email.deliver_later
    Rails.logger.error("ActionMailer error: #{error}")
  end
end
