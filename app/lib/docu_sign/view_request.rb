# frozen_string_literal: true

module DocuSign
  # Docusign Recipient View Request
  class ViewRequest
    ROLES = {
      'staff' => '1000',
      'seller' => '1001',
      'second_seller' => '1002'
    }.freeze

    def perform(envelope_id:, return_url:, name:, email:, role:)
      return 'not-used' if APOLLO_INTERNAL_PRODUCTION

      uri = URI("https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes/#{envelope_id}/views/recipient")
      Net::HTTP.start('na3.docusign.net', 443, use_ssl: true) do |http|
        req = Net::HTTP::Post.new(uri)
        req['Content-Type'] = 'application/json'
        req['Authorization'] = "Bearer #{DocuSign::TokenRequest.new.perform}"
        req.body = body_json(return_url, name, email, role).to_json
        response = http.request(req)
        JSON.parse(response.body)['url']
      end
    end

    private

    def body_json(return_url, name, email, role)
      {
        'returnUrl' => return_url,
        'authenticationMethod' => 'none',
        'userName' => name,
        'email' => email,
        'clientUserId' => constant_hash(role)
      }
    end

    def constant_hash(role)
      ROLES[role.to_s]
    end
  end
end
