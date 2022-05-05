require "test_helper"

class ScoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  ['Utah', 'North Carolina', 'California'].each do |state|
     test "post scouts_path for #{state}" do
       @project.update(state: state)
       stub_request(:post, 'https://example.com/testing')
         .to_return(status: 200, body: 'abcdefgh-1234-1234-1234-9a7c64d0zzzz', headers: {})
       post scouts_path, params: {scout: {project_id: @project.id}}, headers: { accept: Mime[:turbo_stream].to_s }
       assert_equal "200", response.code
     end
  end
end
