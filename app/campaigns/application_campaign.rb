class ApplicationCampaign < Heya::Campaigns::Base
  default from: ActionMailer::Base.email_address_with_name("peter@tweetsweeper.app", "Pete from Tweet Sweeper")
end
