# Preview all emails at http://localhost:3000/rails/mailers/notifications_mailer
class NotificationsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifications_mailer/inquiry
  def inquiry
    NotificationsMailer.inquiry(
      FactoryBot.build(:inquiry)
    )
  end

end
