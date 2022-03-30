require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "get /users/sign_in" do
    get "/users/sign_in"
    assert_equal "200", response.code
  end

  test "delete /users/sign_out" do
    sign_in create(:user)

    delete "/users/sign_out"
    assert_equal "302", response.code
  end
end
