require "test_helper"

class KodaksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test "DELETE /kodaks" do
    @project.kodaks.create
    delete "/kodaks", params: {"authenticity_token"=>"[FILTERED]", "kodak"=>@project.kodaks.last.id, "project"=>@project.id}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "204", response.code
  end

  test 'PATCH /kodaks?id=n' do
    @project.kodaks.create
    patch "/kodaks?id=#{@project.kodaks.last.id}", params: {"kodak"=>{"primary"=>"1"}, "id"=>@project.kodaks.last.id}, headers: { accept: Mime[:turbo_stream].to_s }
  end

  test "POST /kodaks" do
    post "/kodaks", params: {"project"=>@project.id, "file"=>fixture_file_upload('apple.jpg', 'image/jpeg') }, headers: { accept: Mime[:json].to_s }
    assert_equal "204", response.code
  end
end
