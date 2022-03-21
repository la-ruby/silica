class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{APOLLO_NAKED_DOMAIN}"
  layout "mailer"
end
