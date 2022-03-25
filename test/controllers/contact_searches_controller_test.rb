require "test_helper"

class ContactSearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in create(:user)
  end

  [ 'desc', 'asc', ''].each do |item|
    test "POST /contact_searches #{item}" do
      post "/contact_searches", params: {"authenticity_token"=>"[FILTERED]", "contact_search"=>{"sort"=>"sendgrid_created_at", "direction"=>item, "page"=>"1", "query"=>"testing"}}, headers: { accept: Mime[:turbo_stream].to_s }
      assert_equal "200", response.code
    end
  end
end
