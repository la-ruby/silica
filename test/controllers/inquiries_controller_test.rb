require "test_helper"

class InquiriesControllerTest < ActionDispatch::IntegrationTest
  test "POST /inquiries" do
    post "/inquiries", params: {"authenticity_token"=>"[FILTERED]", "inquiry"=>{"ip"=>"127.0.0.1", "url"=>"http://testing.com/listings/125", "name"=>"testing", "email"=>"testing@testing.com", "phone"=>"testing"}}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
