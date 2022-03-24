# frozen_string_literal: true

module DocuSign
  class EnvelopeRequestAlternative
    def perform(options = {})
      return "mock#{SecureRandom.hex[0..6]}" if APOLLO_INTERNAL_PRODUCTION

      uri = URI("https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes")
      Net::HTTP.start(uri.host, 443, use_ssl: true) do |http|
        req = Net::HTTP::Post.new(uri)
        req['Content-Type'] = 'application/json'
        req['Authorization'] = "Bearer #{DocuSign::TokenRequest.new.perform}"
        req.body = EnvelopeRequestBodyAlternative.new(options).to_json
        response = http.request(req)
        JSON.parse(response.body)['envelopeId']
      end
    end
  end
end
