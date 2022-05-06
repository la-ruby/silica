require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in create(:user)
  end

  test "get index as admin" do
    project = create(:project, status: 'Open')
    project = create(:project, status: 'Completed Won')
    project = create(:project, status: 'Completed Closed/Lost')

    get "/projects"
    assert_equal "200", response.code
  end

  test 'patch /projects/:id' do
    project = create(:project)
    patch project_path(project), params: {"authenticity_token"=>"[FILTERED]", "project"=>{"lender_1"=>"testing", "lender_2"=>"aaa"}, "id"=>"147"} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "get new project page as admin" do
    project = create(:project)
    get "/projects/new"
    assert_equal "200", response.code
  end

  test "post create" do
    project = create(:project)
    post "/projects", params: {"project"=>{"a1631804549"=>"1234 Schaufele Avenue, Examplecity, CA, USA", "zip"=>"90808", "city"=>"Examplecity", "state"=>"CA", "street"=>"3828 Schaufele Ave", "name"=>"a", "phone"=>"1234567890", "email"=>"a@a.com", "secondName"=>"", "secondPhone"=>"", "secondEmail"=>"", "expectedtimeline"=>"Exploring options"}} #, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "302", response.code
  end

  test "post create fails" do
    project = create(:project)
    post "/projects", params: {"project"=>{"a1631804549"=>"1234 Schaufele Avenue, Examplecity, CA, USA", "zip"=>"90808", "city"=>"Long Beach", "state"=>"CA", "street"=>"1234 Examplecity Ave", "name"=>"a", "phone"=>"b", "email"=>"a@a.com", "secondName"=>"", "secondPhone"=>"", "secondEmail"=>"", "expectedtimeline"=>"Exploring options"}} #, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "422", response.code
  end

  test "post create fails due to invalid secondPhone" do
    project = create(:project)
    post "/projects", params: {"authenticity_token"=>"[FILTERED]", "project"=>{"status"=>"Open", "direction"=>"Outbound", "req_date"=>"2022-02-16T19:04:02-08:00", "street"=>"1234 Wilshire Blvd", "street2"=>"", "city"=>"Examplecity", "state"=>"CA", "zip"=>"90017", "name"=>"testing", "phone"=>"1234567890", "email"=>"example@example.com", "secondName"=>"testing", "secondPhone"=>"1234", "secondEmail"=>"testing", "expectedtimeline"=>"ASAP"}, "a1631804549"=>"1234 Wilshire Boulevard, Examplecity, CA, USA"} #, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "422", response.code
  end

  test "get /projects/n/overview for status" do
    project = create(:project)
    ["Open", "Completed Closed/Lost", "Completed Won", "testing"].each do |item|
      project.update(status: item)
      get "/projects/#{project.id}?tab=overview"
      assert_equal "200", response.code
    end
  end

  test "get /projects/n/overview owner_occupied true" do
    project = create(:project)
    project.update(owner_occupied: 'true')

    get "/projects/#{project.id}?tab=overview"
    assert_equal "200", response.code
  end

  test "get /projects/n/overview owner_occupied false" do
    project = create(:project)
    project.update(owner_occupied: 'false')

    get "/projects/#{project.id}?tab=overview"
    assert_equal "200", response.code
  end


  test "get /projects/n/offer" do
    project = create(:project)
    get "/projects/#{project.id}?tab=offer"
    assert_equal "200", response.code
  end

  test "get inspection" do
    project = create(:project)
    get "/projects/#{project.id}?tab=inspection"
    assert_equal "200", response.code
  end

  test "get inspection_report" do
    project = create(:project)
    get "/projects/#{project.id}?tab=inspection_inspection_report"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer" do
    project = create(:project)
    get "/projects/#{project.id}?tab=underwriting_review_offer"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer projectInCompletedClosedLostState" do
    project = create(:project)
    project.update(status: "Completed Closed/Lost")

    get "/projects/#{project.id}?tab=underwriting_review_offer"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer projectInCompletedWon" do
    project = create(:project)
    project.update(status: "Completed Won")

    get "/projects/#{project.id}?tab=underwriting_review_offer"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer accepted" do
    project = create(:project)
    Repc.all.update(accepted_at: Time.now.iso8601)

    get "/projects/#{project.id}?tab=underwriting_review_offer"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer rejected" do
    project = create(:project)
    Repc.all.update(rejected_at: Time.now.iso8601)

    get "/projects/#{project.id}?tab=underwriting_review_offer"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer second_seller_mode" do
    project = create(:project)
    Project.all.update(secondName: 'example', secondEmail: 'example@example.net', secondPhone: '(310) 123-4568')

    get "/projects/#{project.id}?tab=underwriting_review_offer"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer second_seller_mode mostly accepted" do
    project = create(:project)
    Project.all.update(secondName: 'example', secondEmail: 'example@example.net', secondPhone: '(310) 123-4568')
    Repc.all.update(accepted_at: Time.now.iso8601, second_seller_accepted_at: Time.now.iso8601)

    get "/projects/#{project.id}?tab=underwriting_review_offer"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer second_seller_mode mostly rejected" do
    project = create(:project)
    Project.all.update(secondName: 'example', secondEmail: 'example@example.net', secondPhone: '(310) 123-4568')
    Repc.all.update(rejected_at: Time.now.iso8601, second_seller_rejected_at: Time.now.iso8601)

    get "/projects/#{project.id}?tab=underwriting_review_offer"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer signing_complete" do
    project = create(:project)
    project.repc.update(docusign_envelope_id: 'testing')

    get "/projects/#{project.id}?tab=underwriting_review_offer&event=signing_complete&envelope_id=testing"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer signing_complete variation" do
    project = create(:project, :has_av)
    project.addendums.last.addendum_versions.last.update(docusign_envelope_id: 'testing')

    get "/projects/#{project.id}?tab=underwriting_review_offer&event=signing_complete&envelope_id=testing"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer signing_complete has rejection variation" do
    project = create(:project, :has_av)
    project.addendums.last.addendum_versions.last.update(docusign_envelope_id: 'testing', rejected_at: Time.now.iso8601)

    get "/projects/#{project.id}?tab=underwriting_review_offer&event=signing_complete&envelope_id=testing"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer signing_complete dual has rejection variation" do
    project = create(:project, :has_av)
    project.dual_for_testing!
    project.addendums.last.addendum_versions.last.update(docusign_envelope_id: 'testing', rejected_at: Time.now.iso8601)

    get "/projects/#{project.id}?tab=underwriting_review_offer&event=signing_complete&envelope_id=testing"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer signing_complete dual has rejections variation" do
    project = create(:project, :has_av)
    project.dual_for_testing!
    project.addendums.last.addendum_versions.last.update(docusign_envelope_id: 'testing', rejected_at: Time.now.iso8601, second_seller_rejected_at: Time.now.iso8601)

    get "/projects/#{project.id}?tab=underwriting_review_offer&event=signing_complete&envelope_id=testing"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer signing_complete dual has acceptance variation" do
    project = create(:project, :has_av)
    project.dual_for_testing!
    project.addendums.last.addendum_versions.last.update(docusign_envelope_id: 'testing', accepted_at: Time.now.iso8601)

    get "/projects/#{project.id}?tab=underwriting_review_offer&event=signing_complete&envelope_id=testing"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer signing_complete dual has acceptances variation" do
    project = create(:project, :has_av)
    project.dual_for_testing!
    project.addendums.last.addendum_versions.last.update(docusign_envelope_id: 'testing', accepted_at: Time.now.iso8601, second_seller_accepted_at: Time.now.iso8601)

    get "/projects/#{project.id}?tab=underwriting_review_offer&event=signing_complete&envelope_id=testing"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer signing_complete has acceptance variation" do
    project = create(:project, :has_av)
    project.addendums.last.addendum_versions.last.update(docusign_envelope_id: 'testing', accepted_at: Time.now.iso8601)

    get "/projects/#{project.id}?tab=underwriting_review_offer&event=signing_complete&envelope_id=testing"
    assert_equal "200", response.code
  end

  test "get underwriting_review_offer mature repc" do
    project = create(:project)
    project.repc.mature_for_testing!

    get "/projects/#{project.id}?tab=underwriting_review_offer"
    assert_equal "200", response.code
  end

  test "get underwriting_prepare_repc" do
    project = create(:project)
    get "/projects/#{project.id}?tab=underwriting_prepare_repc"
    assert_equal "200", response.code
  end

  test "get underwriting_prepare_repc with BOOTSTRAP_UPGRADE truthy" do
    Object.stub_const(:BOOTSTRAP_UPGRADE, true) do
      project = create(:project)
      get "/projects/#{project.id}?tab=underwriting_prepare_repc"
      assert_equal "200", response.code
    end
  end

  test "get underwriting_prepare_repc signing_complete" do
    project = create(:project)
    project.repc.update(docusign_envelope_id: 'testing')

    get "/projects/#{project.id}?tab=underwriting_prepare_repc?event=signing_complete&envelope_id=testing"
    assert_equal "200", response.code
  end

  test "get underwriting_prepare_repc signing_complete for addendum_version" do
    project = create(:project, :has_av)
    project.addendums.last.addendum_versions.last.update(docusign_envelope_id: 'testing')

    get "/projects/#{project.id}?tab=underwriting_prepare_repc?event=signing_complete&envelope_id=testing"
    assert_equal "200", response.code
  end

  test "get underwriting_property_analysis" do
    stub_request(:post, 'https://example.com/testing_path')
    project = create(:project)
    get "/projects/#{project.id}?tab=underwriting_property_analysis"
    assert_equal "200", response.code
  end

  test "get underwriting_intake_form" do
    project = create(:project)
    get "/projects/#{project.id}?tab=underwriting_intake_form"
    assert_equal "200", response.code
  end

  # test "get dispositions_checklist" do
  #   project = create(:project)
  #   get "/projects/#{project.id}/dispositions_checklist"
  #   assert_equal "200", response.code
  # end

  # test "get dispositions_prepare_listing" do
  #   project = create(:project)
  #   get "/projects/#{project.id}/dispositions_prepare_listing"
  #   assert_equal "200", response.code
  # end

  test "get marketplace" do
    project = create(:project)
    get "/projects/#{project.id}?tab=marketplace"
    assert_equal "200", response.code
  end

  test "get activity" do
    project = create(:project)
    create(:event, :project_creation)

    get "/projects/#{project.id}?tab=activity"
    assert_equal "200", response.code
  end

  test "get files" do
    project = create(:project)
    project_file = project.project_files.create
    project_file.silicafile.attach(
      io: File.open('test/fixtures/files/apple.jpg'),
      filename: 'apple.jpg'
    )

    get "/projects/#{project.id}?tab=files&folder=/"
    assert_equal "200", response.code
  end

  test "get files /2" do
    project = create(:project)
    project_file = project.project_files.create
    project_file.silicafile.attach(
      io: File.open('test/fixtures/files/apple.jpg'),
      filename: 'apple.jpg'
    )
    ProjectFile.last.update(folder: '/example/')

    get "/projects/#{project.id}?tab=files&folder=/example/"
    assert_equal "200", response.code
  end

  test "get /projects/n/overview variation" do
    project = create(:project)
    get "/projects/#{project.id}?tab=overview"
    assert_equal "200", response.code
  end

  test "get /projects/n/overview variation 2" do
    project = create(:project)
    get "/projects/#{project.id}?tab=overview"
    assert_equal "200", response.code
  end

  test 'post /projects/:id/download_property_analysis' do
    project = create(:project)
    post "/projects/#{project.id}/download_property_analysis", headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test 'get /projects/:id?tab=dispositions_checklist' do
    project = create(:project)
    get "/projects/#{project.id}?tab=dispositions_checklist"
    assert_equal "200", response.code
  end

  test 'get /projects/:id?tab=dispositions_prepare_listing' do
    project = create(:project)
    get "/projects/#{project.id}?tab=dispositions_prepare_listing"
    assert_equal "200", response.code
  end
end
