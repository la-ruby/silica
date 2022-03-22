require "test_helper"

class FiltersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test "POST /filters" do
    post "/filters", params: {"authenticity_token"=>"[FILTERED]", "page"=>"", "query"=>"testing", "statefilter"=>"CA", "cityfilter"=>"Bountiful", "sourcefilter"=>"Inbound", "statusfilter" =>"Open", "req_date"=>"2022-03-01 to 2022-03-09", "offer_sent"=>"2022-03-01 to 2022-03-09"}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
