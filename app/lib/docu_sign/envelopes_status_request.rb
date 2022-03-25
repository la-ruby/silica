# frozen_string_literal: true

require 'docusign_esign'

module DocuSign
  # Fetches fresh oauth token
  class EnvelopesStatusRequest
    # TODO: if the token is valid, return that thus saving a roundrip
    # :reek:UtilityFunction
    def perform
      envelopes_api = DocuSign_eSign::EnvelopesApi.new(DocuSign::ApiClient.new.api_client)
      options = DocuSign_eSign::ListStatusOptions.new
      options.from_date = 4.days.ago.strftime('%Y-%m-%d')
      options.status = 'completed'
      envelopes_api.list_status(DOCU_SIGN_ACCOUNT_ID, {}, options).envelopes
    end
  end
end
