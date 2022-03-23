require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in create(:user)
    create(:project)
  end

  test "should get index" do
    get contacts_url
    assert_response :success
  end

  test "should  create contact" do
    post contacts_url, params: {"authenticity_token"=>"[FILTERED]", "contact"=>{"first_name"=>"a", "last_name"=>"b", "phone"=>"c", "email"=>""}}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_response :success
  end
end
