require "test_helper"

class ProjectFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in create(:user)
  end

  test "should show project file" do
    project = create(:project)
    project_file = project.project_files.create
    project_file.silicafile.attach(
      io: File.open('test/fixtures/files/apple.jpg'),
      filename: 'apple.jpg'
    )

    get "/project_files/#{project_file.id}"
    assert_response :redirect
  end
end
