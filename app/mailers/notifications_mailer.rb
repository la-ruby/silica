class NotificationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.signup.subject
  #
  def inquiry(inquiry)
    @inquiry = inquiry
    ip_prefix = (APOLLO_INTERNAL_PRODUCTION ? "[INTERNAL PRODUCTION] " : "")

    mail(
      to: "#{SILICA_SUPPORT}",
      bcc: [ APOLLO_ADMIN_LOGIN ],
      subject: "#{ip_prefix} Someone clicked the \"Request Info\" button")
  end

  def tx_scout_link(project)
    @project = project
    mail(
      to: project.email,
      bcc: [ APOLLO_ADMIN_LOGIN ],
      subject: "Here's your Mobile Property Inspection Link")
  end
end
