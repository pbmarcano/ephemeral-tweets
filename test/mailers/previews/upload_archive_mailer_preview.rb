# Preview all emails at http://localhost:3000/rails/mailers/archive_uploader_mailer
class UploadArchiveMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/archive_uploader_mailer/bad_file
  def bad_file
    UploadArchiveMailer.bad_file(user: User.first)
  end

end
