class TwitterUnauthorizedCampaign < ApplicationCampaign
  step :first, wait: 0,
    subject: "We're having trouble connecting to your Twitter account"

  step :second, wait: 1.day,
    subject: "Our Twitter connection issues continue..."

  step :third, wait: 1.day,
    subject: "Tweet Sweeper's been disconnected for 2 days"

  step :fourth, wait: 3.days,
    subject: "Tweet Sweeper's been disconnected for 5 days"

  step :fifth, wait: 2.days,
    subject: "Tweet Sweeper's been disconnected for a week"
end
