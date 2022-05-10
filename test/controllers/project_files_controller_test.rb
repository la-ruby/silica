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

  test "should get new" do
    project = create(:project)

    get "/projects/#{project.id}/project_files/new"
    assert_response :success
  end

  test "should create project_file" do
    project = create(:project)

    assert_difference("ProjectFile.count") do
      post "/projects/#{project.id}/project_files", params: {"file"=> Rack::Test::UploadedFile.new("./test/fixtures/files/apple.jpg", "image/jpeg"), "folder"=>"/", "submit"=>"Submit", "project_id"=> project.id}
    end
  end

end
