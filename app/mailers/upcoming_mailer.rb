class UpcomingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.upcoming_mailer.notify.subject
  #
  def notify(user)
    @user = user
    @upcoming_review = UpcomingReview.new(user)

    mail to: @user.email, subject: "#{@upcoming_review.tweets_this_week.count} tweets getting deleted this week"
  end
end
