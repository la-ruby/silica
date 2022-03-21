require "test_helper"

class AddendumVerdictsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project, :has_av)
    sign_in create(:user)
  end

  test "POST /addendum_verdicts accetance" do
    stub_docusign_token_request
    stub_docusign_recipient_views_request
    stub_docusign_envelope_creation
    stub_docusign_recipient_views_request_4

    post "/addendum_verdicts", params: {"authenticity_token"=>"[FILTERED]", "repc_id"=>@project.repcs.last.id, "addendum_version_id"=>@project.addendums.last.addendum_versions.last.id, "second_seller_mode"=>"false", "action_button"=>"sign_via_docusign"}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "POST /addendum_verdicts acceptance isDual" do
    @project.dual_for_testing!
    stub_docusign_token_request
    stub_docusign_envelope_creation
    stub_docusign_recipient_views_request_4

    post "/addendum_verdicts", params: {"authenticity_token"=>"[FILTERED]", "repc_id"=>@project.repcs.last.id, "addendum_version_id"=>@project.addendums.last.addendum_versions.last.id, "second_seller_mode"=>"true", "action_button"=>"sign_via_docusign"}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "POST /addendum_verdicts rejection" do
    stub_docusign_token_request
    stub_docusign_recipient_views_request
    stub_docusign_envelope_creation
    stub_sendgrid_mail

    post "/addendum_verdicts", params: {"authenticity_token"=>"[FILTERED]", "repc_id"=>@project.repcs.last.id, "addendum_version_id"=>@project.addendums.last.addendum_versions.last.id, "second_seller_mode"=>"false", "action_button"=>"reject"}    , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "POST /addendum_verdicts rejection isDual" do
    stub_docusign_token_request
    @project.dual_for_testing!

    stub_docusign_envelope_creation
    stub_docusign_recipient_views_request_4
    stub_sendgrid_mail

    post "/addendum_verdicts", params: {"authenticity_token"=>"[FILTERED]", "repc_id"=>@project.repcs.last.id, "addendum_version_id"=>@project.addendums.last.addendum_versions.last.id, "second_seller_mode"=>"true", "action_button"=>"reject"}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
