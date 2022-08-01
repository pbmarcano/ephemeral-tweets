class UploadArchiveMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.archive_uploader_mailer.bad_file.subject
  #
  def bad_file(user:)
    @user = user

    if @user.email.present?
      mail to: @user.email
    end
  end
end
