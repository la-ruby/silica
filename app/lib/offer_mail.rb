# frozen_string_literal: true

class OfferMail
  def perform(to:, mop_token:, name:)
    Rails.logger.info 'D3BUG Sending email'
    to = [{ email: to }]
    to = [{ email: APOLLO_ADMIN_LOGIN }] if APOLLO_INTERNAL_PRODUCTION

    data = {
      personalizations: [
        {
          to: to,
          bcc: [{ email: APOLLO_ADMIN_LOGIN }],
          dynamic_template_data: {
            id: 'unusedLegacy',
            signer: 'unusedLegacy',
            token: mop_token,
            name: name,
            representative: { name: APOLLO_PURCHASER_NAME, email: APOLLO_PURCHASER_EMAIL,
                              phone: APOLLO_PURCHASER_PHONE },
            apollo_full_domain: APOLLO_PORTAL_FULL_DOMAIN
          }
        }
      ],
      from: { email: "#{COMPANY} <#{SILICA_SUPPORT}>" },
      template_id: SENDGRID_TEMPLATE_REPC,
      mail_settings: { sandbox_mode: { enable: !Rails.env.production? } }
    }
    sg = SendGrid::API.new(api_key: SENDGRID_API_KEY)
    begin
      response = sg.client.mail._('send').post(request_body: data)
      Rails.logger.info response.inspect
      response.headers['x-message-id'][0]
    end
  end
end
