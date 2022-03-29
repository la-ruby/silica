require "test_helper"

class AgreesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user, :staff)
  end

  test "patch /configuration" do
    patch configuration_path, params: {}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test "get /configuration/edit" do
    get edit_configuration_path
    assert_equal "200", response.code
  end
end
