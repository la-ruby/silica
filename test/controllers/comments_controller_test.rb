require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test "comment creation" do
    post "/comments", params: {"comment"=>{"record_id"=>@project.id, "record_type"=>"Project", "content"=>"<div>testing</div>"}}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "204", response.code
  end
end
