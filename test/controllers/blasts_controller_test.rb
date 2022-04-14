require "test_helper"

class BlastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test "POST /blasts" do
    @project.listing.update(walkthrough_date: "2022-02-04")
    @project.listing.update(walkthrough_time: "18:30")
    stub_request(:post, "https://api.sendgrid.com/v3/marketing/singlesends").
      to_return(status: 200, body: '{"id": "testing"}', headers: {})
    stub_request(:put, "https://api.sendgrid.com/v3/marketing/singlesends/testing/schedule").
      to_return(status: 200, body: '{"html_content": "", "plain_content": ""}', headers: {})
    stub_request(:get, "https://api.sendgrid.com/v3/designs/#{SENDGRID_DESIGN}").
      to_return(status: 200, body: '{"html_content": "", "plain_content": ""}', headers: {})

    post "/blasts", params:  {"blast"=>{"project"=>@project.id}}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "POST /blasts fake_send" do
    @project.listing.update(walkthrough_date: "2022-02-04")
    @project.listing.update(walkthrough_time: "18:30")
    stub_request(:post, "https://api.sendgrid.com/v3/marketing/singlesends").
      to_return(status: 200, body: '{"id": "testing"}', headers: {})
    stub_request(:put, "https://api.sendgrid.com/v3/marketing/singlesends/testing/schedule").
      to_return(status: 200, body: '{"html_content": "", "plain_content": ""}', headers: {})
    stub_request(:get, "https://api.sendgrid.com/v3/designs/#{SENDGRID_DESIGN}").
      to_return(status: 200, body: '{"html_content": "", "plain_content": ""}', headers: {})

    post "/blasts", params:  {"blast"=>{"project"=>@project.id}, "what_was_clicked"=>'fake_send'}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
