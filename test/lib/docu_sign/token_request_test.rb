require "test_helper"

class DocusignTokenRequestTest < ActiveSupport::TestCase
  test "#perform" do
    stub_docusign_token_request
    assert_match(/\Atesting/, DocuSign::TokenRequest.new.perform)
  end
end
