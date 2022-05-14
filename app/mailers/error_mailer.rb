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

  def bad_user_email
    mail to: "peter@tweetsweeper.app",
      subject: "Bad email address",
      content_type: "text/html",
      body: "<html><body><p>Bad email address</p><p>Error: #{params[:error]}</p></body></html>"
  end
end
