# frozen_string_literal: true

# Addendum Mail
class AddendumMail
  def perform(to:, mop_token:, name:, street:)
    Rails.logger.info 'Sending email'
    to = APOLLO_INTERNAL_PRODUCTION ? [{ email: APOLLO_ADMIN_LOGIN }] : [{ email: to }]
    data = addendum_data(to, mop_token, name, street)
    sg = SendGrid::API.new(api_key: SENDGRID_API_KEY)
    begin
      response = sg.client.mail._('send').post(request_body: data)
      Rails.logger.info response.inspect
      response.headers['x-message-id'][0]
    end
  end

  private

  def addendum_data(to, mop_token, name, street)
    { personalizations: [{
      to: to, bcc: [{ email: APOLLO_ADMIN_LOGIN }],
      dynamic_template_data: { id: 'unusedLegacy', signer: 'unusedLegacy', token: mop_token,
                               name: name, representative: { name: APOLLO_PURCHASER_NAME, email: APOLLO_PURCHASER_EMAIL,
                                                             phone: APOLLO_PURCHASER_PHONE },
                               apollo_full_domain: APOLLO_PORTAL_FULL_DOMAIN, street: street }
    }],
      from: { email: "#{COMPANY} <#{SILICA_SUPPORT}>" }, template_id: SENDGRID_TEMPLATE_ADDENDUM,
      mail_settings: { sandbox_mode: { enable: !Rails.env.production? } } }
  end
end
