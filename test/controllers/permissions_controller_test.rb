require "test_helper"

class PermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test "get /permissions" do
    get "/permissions"
    assert_equal "200", response.code
  end


  test "patch /permissions" do
    patch "/permissions", params: {"authenticity_token"=>"[FILTERED]", "user_id"=>User.first.id, "permissions"=>["", "reader"]}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
