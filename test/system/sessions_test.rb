require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  test "ability to login" do
    login_flow
    assert_selector "span", text: "My Dashboard"
  end
end
