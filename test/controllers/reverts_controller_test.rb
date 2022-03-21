require "test_helper"

class ReversControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in create(:user)
  end

  test "revert creation" do
    post reverts_url, params: {}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "302", response.code
  end

end
