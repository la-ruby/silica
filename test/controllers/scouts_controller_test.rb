require "test_helper"

class ScoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test 'post scouts_path' do
    stub_request(:post, 'https://example.com/testing')
    #VCR.use_cassette('gitignored', :record => :all) do
      post scouts_path, params: {scout: {project_id: @project.id}}, headers: { accept: Mime[:turbo_stream].to_s }
      assert_equal "200", response.code
    #end
  end
end
