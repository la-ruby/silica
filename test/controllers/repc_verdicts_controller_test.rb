require "test_helper"

class RepcVerdictsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test "POST /repc_verdicts accetance" do
    stub_docusign_token_request
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes/68027dbd-142c-4f7a-a4a2-89e10fdd41f3/views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes").to_return(status: 200, body: {"envelopeId":"68027dbd-142c-4f7a-a4a2-89e10testing","uri":"/envelopes/68027dbd-142c-4f7a-a4a2-89e10testing","statusDateTime":"2022-01-17T15:54:31.2800000Z","status":"sent"}.to_json, headers: {})
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes//views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})

    post "/repc_verdicts", params: {"authenticity_token"=>"[FILTERED]", "repc_id"=>@project.repcs.last.id, "second_seller_mode"=>"false", "action_button"=>"sign_via_docusign"}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "POST /repc_verdicts acceptance isDual" do
    @project.dual_for_testing!
    stub_docusign_token_request

    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes/68027dbd-142c-4f7a-a4a2-89e10fdd41f3/views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes").to_return(status: 200, body: {"envelopeId":"68027dbd-142c-4f7a-a4a2-89e10testing","uri":"/envelopes/68027dbd-142c-4f7a-a4a2-89e10testing","statusDateTime":"2022-01-17T15:54:31.2800000Z","status":"sent"}.to_json, headers: {})
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes//views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})

    post "/repc_verdicts", params: {"authenticity_token"=>"[FILTERED]", "repc_id"=>@project.repcs.last.id, "second_seller_mode"=>"true", "action_button"=>"sign_via_docusign"}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "POST /repc_verdicts rejection" do
    stub_docusign_token_request

    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes/68027dbd-142c-4f7a-a4a2-89e10fdd41f3/views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes").to_return(status: 200, body: {"envelopeId":"68027dbd-142c-4f7a-a4a2-89e10testing","uri":"/envelopes/68027dbd-142c-4f7a-a4a2-89e10testing","statusDateTime":"2022-01-17T15:54:31.2800000Z","status":"sent"}.to_json, headers: {})
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes//views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})

    stub_request(:post, "https://api.sendgrid.com/v3/mail/send").to_return(status: 200, body: "", headers: {'x-message-id'=>'example'})

    post "/repc_verdicts", params: {"authenticity_token"=>"[FILTERED]", "repc_id"=>@project.repcs.last.id, "addendum_version_id"=>"25", "second_seller_mode"=>"false", "action_button"=>"reject"}    , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "POST /repc_verdicts rejection isDual" do
    stub_docusign_token_request
    @project.dual_for_testing!

    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes/68027dbd-142c-4f7a-a4a2-89e10fdd41f3/views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes").to_return(status: 200, body: {"envelopeId":"68027dbd-142c-4f7a-a4a2-89e10testing","uri":"/envelopes/68027dbd-142c-4f7a-a4a2-89e10testing","statusDateTime":"2022-01-17T15:54:31.2800000Z","status":"sent"}.to_json, headers: {})
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes//views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})

    stub_request(:post, "https://api.sendgrid.com/v3/mail/send").to_return(status: 200, body: "", headers: {'x-message-id'=>'example'})

    post "/repc_verdicts", params: {"authenticity_token"=>"[FILTERED]", "repc_id"=>@project.repcs.last.id, "addendum_version_id"=>"25", "second_seller_mode"=>"true", "action_button"=>"reject"}    , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end


end
