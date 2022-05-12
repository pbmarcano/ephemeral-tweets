class TwitterUnauthorizedCampaign < ApplicationCampaign
  step :first,
    subject: "We're having trouble connecting with your Twitter account"

  step :second,
    subject: "Our Twitter connection issues continue..."

  step :third,
    subject: "Third"

  step :fourth,
    subject: "Fourth"

  step :fifth,
    subject: "Fifth"
end
