require "test_helper"

class AddendumVersionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in create(:user)
  end

  test "POST /addendum_versions" do
    project = create(:project)
    post "/addendum_versions", params: {"authenticity_token"=>"[FILTERED]", "project_id"=>project.id}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  # these copied over from elsewhere
  test "patch submission for addendum_version" do
    project = create(:project, :has_av)
    stub_docusign_token_request
    stub_docusign_envelope_creation
    stub_docusign_recipient_views_request_alternative

    patch "/addendum_versions/#{AddendumVersion.last.id}", params: {"what_was_clicked"=>"sign_addendum_version", "addendum_version"=>{"expiration"=>"2022-01-01T09:22", "deadline"=>"2022-01-02T09:22", "terms"=>"memo"}}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "patch submission for addendum_version isDual" do
    project = create(:project, :has_av)
    project.dual_for_testing!
    stub_docusign_envelope_creation
    stub_docusign_recipient_views_request_alternative
    stub_docusign_token_request

    patch "/addendum_versions/#{AddendumVersion.last.id}", params: {"authenticity_token"=>"[FILTERED]", "what_was_clicked"=>"sign_addendum_version", "addendum_version"=>{"expiration"=>"2022-01-01T09:22", "deadline"=>"2022-01-02T09:22", "terms"=>"memo" }}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "patch submission for addendum_version basicSave" do
    project = create(:project, :has_av)

    patch "/addendum_versions/#{AddendumVersion.last.id}", params: {"authenticity_token"=>"[FILTERED]", "addendum_version"=>{"expiration"=>"", "deadline"=>"", "terms"=>"testing"}}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "patch submission for addendum_version whatWasClickedsend_addendum_version_to_seller" do
    project = create(:project, :has_av)
    project.dual_for_testing!
    stub_sendgrid_mail

    patch "/addendum_versions/#{AddendumVersion.last.id}", params: {"authenticity_token"=>"[FILTERED]", "what_was_clicked"=>"send_addendum_version_to_seller", "addendum_version"=>{'testing'=>'testing'}}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "patch submission for addendum_version whatWasClickedIsdiscard_addendum_version" do
    project = create(:project, :has_av)

    patch "/addendum_versions/#{AddendumVersion.last.id}", params: {"authenticity_token"=>"[FILTERED]", "what_was_clicked"=>"discard_addendum_version", "addendum_version"=>{'testing'=>'testing'}}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "patch submission for addendum_version docusign_envelope_id.present" do
    stub_docusign_token_request
    stub_docusign_recipient_views_request_3
    project = create(:project, :has_av)
    AddendumVersion.last.update(docusign_envelope_id: "testing")

    patch "/addendum_versions/#{AddendumVersion.last.id}", params: {"authenticity_token"=>"[FILTERED]", "what_was_clicked"=>"sign_addendum_version", "addendum_version"=>{"expiration"=>"2022-01-01T09:22", "deadline"=>"2022-01-02T09:22", "terms"=>"memo" }}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end


  test "patch submission for addendum_version component what_was_clicked sign_addendum_version" do
    stub_docusign_token_request
    stub_docusign_envelope_creation
    stub_docusign_recipient_views_request_alternative
    stub_docusign_recipient_views_request_alternative
    project = create(:project, :has_av)

    patch "/addendum_versions/#{AddendumVersion.last.id}", params: {"authenticity_token"=>"[FILTERED]", "what_was_clicked"=>"sign_addendum_version", "addendum_version"=>{"expiration"=>"", "deadline"=>"", "terms"=>""}}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
  # /these copied over from elsewhere
end
