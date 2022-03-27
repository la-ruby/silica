# frozen_string_literal: true

# Offer Rejected Mail
class OfferRejectedMail
  def perform(to:)
    raise 'Cannot send email without a to email address' unless to.present?

    Rails.logger.info 'Sending email'
    to = APOLLO_INTERNAL_PRODUCTION ? [{ email: APOLLO_ADMIN_LOGIN }] : [{ email: to }]
    data = rejected_data(to)
    sg = SendGrid::API.new(api_key: SENDGRID_API_KEY)
    begin
      response = sg.client.mail._('send').post(request_body: data)
      Rails.logger.info response.inspect
      response.headers['x-message-id'][0]
    end
  end

  private

  def rejected_data(to)
    { personalizations: [{
      to: to, bcc: [{ email: APOLLO_ADMIN_LOGIN }],
      dynamic_template_data: {
        representative: { name: APOLLO_PURCHASER_NAME, email: APOLLO_PURCHASER_EMAIL,
                          phone: APOLLO_PURCHASER_PHONE }
      }
    }],
      from: { email: "#{COMPANY} <#{SILICA_SUPPORT}>" },
      template_id: SENDGRID_TEMPLATE_OFFER_REJECTED,
      mail_settings: { sandbox_mode: { enable: !Rails.env.production? } } }
  end
end
