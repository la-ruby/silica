# frozen_string_literal: true

require 'docusign_esign'

module DocuSign
  # Fetches fresh oauth token
  class TokenRequest
    # TODO: if the token is valid, return that thus saving a roundrip
    # :reek:UtilityFunction
    def perform
      configuration = DocuSign_eSign::Configuration.new
      configuration.host = DOCU_SIGN_BASE_PATH
      api_client = DocuSign_eSign::ApiClient.new configuration 
      api_client.base_path = DOCU_SIGN_BASE_PATH
      Rails.logger.info ">> token request to https://na3.docusign.net/restapi ..."
      api_client
        .request_jwt_user_token(DOCU_SIGN_INTEGRATOR_KEY,
                                DOCU_SIGN_USER_ID,
                                DOCU_SIGN_PRIVATE_KEY,
                                600,
                                'signature impersonation')
        .access_token
    end
  end
end
