class ApplicationCampaign < Heya::Campaigns::Base
  segment { |u| u.email.present? }

  default from: ActionMailer::Base.email_address_with_name("peter@tweetsweeper.app", "Pete via Tweet Sweeper"), bcc: "peter@tweetsweeper.app"
end
