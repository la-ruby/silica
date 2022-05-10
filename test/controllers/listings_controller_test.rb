require "test_helper"

class ListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in(create(:user))
    @project = create(:project, :has_listed)
  end

  test "get listings" do
    get "/listings"
    assert_equal "200", response.code
  end

  test "show listing" do
    get listing_path(@project.listing)
    assert_equal "200", response.code
  end
end
