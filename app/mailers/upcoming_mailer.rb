class UpcomingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.upcoming_mailer.notify.subject
  #
  def notify(user)
    @user = user
    @grouped_tweets = @user.upcoming_tweets_this_week.group_by_deletion_date
    
    tweet_count = @user.upcoming_tweets_this_week.count

    if tweet_count > 0
      mail to: @user.email, 
        subject: default_i18n_subject(
          number_of_tweets: "#{tweet_count} #{"tweet".pluralize(tweet_count)}"
        )
    end
  end
end
