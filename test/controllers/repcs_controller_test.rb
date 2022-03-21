require "test_helper"

class RepcsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test "PATCH /repcs/:id" do
    patch "/repcs/#{@project.repcs.last.id}", params: { "repc"=>{"purchase_price"=>"1", "earnest_money"=>"2", "agreement_date"=>"2022-01-03", "settlement_date"=>"2022-01-04", "notes"=>"climate", "closing_costs_paid_by"=>"seller", "offer_terms"=>"yes", "down_payment"=>"a", "term_length"=>"b", "interest_rate"=>"c", "monthly_payment"=>"d", "estimated_remaining_mortgage"=>"e", "balloon_payment"=>"f", "real_estate_professional"=>"broker"}, "what_was_clicked"=>"save", "id"=>@project.repcs.last.id }, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "PATCH /repcs/:id wasWasClickedSignRepc" do
    stub_docusign_token_request
    stub_docusign_recipient_views_request
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes").to_return(status: 200, body: {"envelopeId":"68027dbd-142c-4f7a-a4a2-89e10testing","uri":"/envelopes/68027dbd-142c-4f7a-a4a2-89e10testing","statusDateTime":"2022-01-17T15:54:31.2800000Z","status":"sent"}.to_json, headers: {})
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes/68027dbd-142c-4f7a-a4a2-89e10testing/views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})

    patch "/repcs/#{@project.repcs.last.id}", params: { "repc"=>{"purchase_price"=>"1", "earnest_money"=>"2", "agreement_date"=>"2022-01-03", "settlement_date"=>"2022-01-04", "notes"=>"climate", "closing_costs_paid_by"=>"seller", "offer_terms"=>"yes", "down_payment"=>"a", "term_length"=>"b", "interest_rate"=>"c", "monthly_payment"=>"d", "estimated_remaining_mortgage"=>"e", "balloon_payment"=>"f", "real_estate_professional"=>"broker"}, "what_was_clicked"=>"sign_repc", "id"=>@project.repcs.last.id }, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end


  test "PATCH /repcs/:id wasWasClickedSignRepc isDual" do
    @project.dual_for_testing!
    stub_docusign_token_request
    stub_docusign_recipient_views_request
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes").to_return(status: 200, body: {"envelopeId":"68027dbd-142c-4f7a-a4a2-89e10testing","uri":"/envelopes/68027dbd-142c-4f7a-a4a2-89e10testing","statusDateTime":"2022-01-17T15:54:31.2800000Z","status":"sent"}.to_json, headers: {})
    stub_request(:post, "https://na3.docusign.net/restapi/v2.1/accounts/#{DOCU_SIGN_ACCOUNT_ID}/envelopes/68027dbd-142c-4f7a-a4a2-89e10testing/views/recipient").to_return(status: 200, body: {url: 'https://example.com'}.to_json, headers: {})

    patch "/repcs/#{@project.repcs.last.id}", params: { "repc"=>{"purchase_price"=>"1", "earnest_money"=>"2", "agreement_date"=>"2022-01-01", "settlement_date"=>"2022-01-01", "inspection_period_deadline"=>"2022-01-01", "possession_date"=>"2022-01-01", "notes"=>"test", "closing_costs_paid_by"=>"buyer", "offer_terms"=>"yes", "down_payment"=>"1", "term_length"=>"2", "interest_rate"=>"3", "monthly_payment"=>"4", "estimated_remaining_mortgage"=>"5", "balloon_payment"=>"6", "real_estate_professional"=>"agent"}, "what_was_clicked"=>"sign_repc", "id"=>@project.repcs.last.id }, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "PATCH /repcs/:id whatWasClickedMakeNewRepc" do
    patch "/repcs/#{@project.repcs.last.id}", params: { "repc"=>{"purchase_price"=>"1", "earnest_money"=>"2", "agreement_date"=>"2022-01-03", "settlement_date"=>"2022-01-04", "notes"=>"climate", "closing_costs_paid_by"=>"seller", "offer_terms"=>"yes", "down_payment"=>"a", "term_length"=>"b", "interest_rate"=>"c", "monthly_payment"=>"d", "estimated_remaining_mortgage"=>"e", "balloon_payment"=>"f", "real_estate_professional"=>"broker"}, "what_was_clicked"=>"make_new_repc", "id"=>@project.repcs.last.id }, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

end
