require "test_helper"

class TxScoutLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in create(:user)
    @project = create(:project)
  end

  test "#create" do
    post tx_scout_links_path, params: { tx_scout_link: { project_id: @project.id }}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

end
