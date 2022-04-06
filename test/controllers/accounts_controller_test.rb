require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test "GET /account" do
    get "/account"
    assert_equal "200", response.code
  end

  test "PATCH /account mismatch" do
    patch "/account", params: {"authenticity_token"=>"[FILTERED]", "password"=>"aaa", "password_confirmation"=>"bbb", "commit"=>"save", "id"=>User.last.id} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "PATCH /account" do
    patch "/account", params: {"authenticity_token"=>"[FILTERED]", "password"=>"testing", "password_confirmation"=>"testing", "commit"=>"save", "id"=>User.last.id} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "PATCH /account oneSideEmpty" do
    patch "/account", params: {"authenticity_token"=>"[FILTERED]", "password"=>"", "password_confirmation"=>"testing", "commit"=>"save", "id"=>User.last.id} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
