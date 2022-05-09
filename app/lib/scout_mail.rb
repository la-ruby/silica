# frozen_string_literal: true

class ScoutMail
  def perform(project)
    Rails.logger.info 'Sending ScoutMail'
    to = [ { "email": project.email } ]    
    data = {
      "personalizations": [
        {
          "to": to,
          "bcc": [ { "email": APOLLO_ADMIN_LOGIN } ],
          "dynamic_template_data": {
            "link": project.scout
          }
        }
      ],
      "from": { "email": "#{COMPANY} <#{SILICA_SUPPORT}>" },
      "template_id": SENDGRID_TEMPLATE_INSPECTION_SERVICE,
      "mail_settings": { "sandbox_mode": { "enable": !Rails.env.production? } }
    }
    sg = SendGrid::API.new(api_key: SENDGRID_API_KEY)
    begin
      response = sg.client.mail._('send').post(request_body: data)
      Rails.logger.info response.inspect
      response.headers['x-message-id'][0]
    end
  end
end
