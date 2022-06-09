class TwitterUnauthorizedCampaign < ApplicationCampaign
  step :first, wait: 0,
    subject: "We're having trouble connecting to your Twitter account"

  step :second, wait: 1.week,
    subject: "Tweet Sweeper's been disconnected for a week"

  step :third, wait: 1.week,
    subject: "Tweet Sweeper's been disconnected for 2 weeks"

  step :fourth, wait: 1.week,
    subject: "Tweet Sweeper's been disconnected for 3 weeks"

  step :fifth, wait: 1.week,
    subject: "Tweet Sweeper's been disconnected for a month"
end
