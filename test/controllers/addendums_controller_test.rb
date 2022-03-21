require "test_helper"

class AddendumsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project, :has_av)
    sign_in create(:user, :staff)
  end

  test "get /addendums/n" do
    get "/addendums/#{@project.addendums.last.id}"
    assert_equal "200", response.code
  end
end
