module DocuSign
  # Docusign Recipient View Request
  class ViewRequest
    def perform(envelope_id:, return_url:, name:, email:, role:)
      return 'not-used' if APOLLO_INTERNAL_PRODUCTION

      if role == :staff
        client_user_id = '1000'
      elsif role == :seller
        client_user_id = '1001'
      elsif role == :second_seller
        client_user_id = '1002'
      end

      body = {
          'returnUrl' => return_url,
          'authenticationMethod' => 'none',
          'userName' => name,
          'email' => email,
          'clientUserId' => client_user_id
      }
      uri = URI("https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes/#{envelope_id}/views/recipient")
      Net::HTTP.start('na3.docusign.net', 443, use_ssl: true) do |http|
        req = Net::HTTP::Post.new(uri)
        req['Content-Type'] = 'application/json'
        req['Authorization'] = "Bearer #{DocuSign::TokenRequest.new.perform}"
        req.body = body.to_json
        response = http.request(req)
        JSON.parse(response.body).dig('url')
      end
    end
  end
end
