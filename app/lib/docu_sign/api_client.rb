# frozen_string_literal: true

require 'docusign_esign'

module DocuSign
  # Api Client
  class ApiClient
    attr_reader :api_client

    def initialize
      configuration = DocuSign_eSign::Configuration.new
      configuration.host = DOCU_SIGN_BASE_PATH
      @api_client = DocuSign_eSign::ApiClient.new configuration
      api_client.base_path = DOCU_SIGN_BASE_PATH
      api_client.default_headers['Authorization'] = "Bearer #{DocuSign::TokenRequest.new.perform}"
    end
  end
end
