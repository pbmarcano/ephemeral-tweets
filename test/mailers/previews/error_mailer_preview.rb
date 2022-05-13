# Preview all emails at http://localhost:3000/rails/mailers/error_mailer
class ErrorMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/error_mailer/no_twitter_user
  def no_twitter_user
    ErrorMailer.with(user: User.first).no_twitter_user
  end
end
