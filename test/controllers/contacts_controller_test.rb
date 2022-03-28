require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in create(:user)
    create(:project)
  end

  test "should get index" do
    create(:contact)

    get contacts_url
    assert_response :success
  end

  test "should create contact" do
    stub_sendgrid_marketing_lists
    stub_sendgrid_export
    stub_sendgrid_export_step2
    stub_sendgrid_export_step3
    stub_sendgrid_contacts_put
    stub_sendgrid_marketing_contacts
    post contacts_url, params: {"authenticity_token"=>"[FILTERED]", "contact"=>{"first_name"=>"a", "last_name"=>"b", "phone"=>"c", "email"=>""}}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_response :success
  end

  test "GET /contacts/refresh" do
    stub_sendgrid_marketing_lists
    stub_sendgrid_export
    stub_sendgrid_export_step2
    stub_sendgrid_export_step3
    stub_sendgrid_marketing_contacts
    get "/contacts/refresh"
    assert_response :redirect
  end
end
