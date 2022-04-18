require "test_helper"

class ProjectFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in create(:user)
  end

  test "should show project file" do
    get "/project_files/testing"
    assert_response :success
  end
end
