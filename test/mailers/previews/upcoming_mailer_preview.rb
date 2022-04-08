# Preview all emails at http://localhost:3000/rails/mailers/upcoming_mailer
class UpcomingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/upcoming_mailer/notify
  def notify
    UpcomingMailer.notify(User.first)
  end

end
