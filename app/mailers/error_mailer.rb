class ErrorMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_mailer.no_twitter_user.subject
  #
  def no_twitter_user
    @user = params[:user]

    if @user.email.present?
      mail to: @user.email, bcc: "peter@tweetsweeper.app"
    end
  end
end
