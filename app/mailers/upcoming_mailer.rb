class UpcomingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.upcoming_mailer.notify.subject
  #
  def notify(user)
    @user = user
    @upcoming_review = UpcomingReview.new(user)
    tweet_count = @upcoming_review.tweets_this_week.count

    if tweet_count > 0
      mail to: @user.email, subject: default_i18n_subject(count: tweet_count)
    end
  end
end
