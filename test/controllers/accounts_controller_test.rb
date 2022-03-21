require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test "GET /accounts/:id" do
    get "/accounts/#{User.last.id}"
    assert_equal "200", response.code
  end

  test "PATCH /accounts/:id mismatch" do
    patch "/accounts/#{User.last.id}", params: {"authenticity_token"=>"[FILTERED]", "password"=>"aaa", "password_confirmation"=>"bbb", "commit"=>"save", "id"=>User.last.id} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "PATCH /accounts/:id" do
    patch "/accounts/#{User.last.id}", params: {"authenticity_token"=>"[FILTERED]", "password"=>"testing", "password_confirmation"=>"testing", "commit"=>"save", "id"=>User.last.id} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "PATCH /accounts/:id oneSideEmpty" do
    patch "/accounts/#{User.last.id}", params: {"authenticity_token"=>"[FILTERED]", "password"=>"", "password_confirmation"=>"testing", "commit"=>"save", "id"=>User.last.id} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
