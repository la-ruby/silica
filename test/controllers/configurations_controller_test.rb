require "test_helper"

class AgreesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user, :staff)
  end

  test "patch /configurations" do
    patch "/configurations", params: {}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "get /configurations" do
    get "/configurations"
    assert_equal "200", response.code
  end
end
