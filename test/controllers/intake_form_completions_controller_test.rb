require "test_helper"

class IntakeFormCompletionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test 'POST /intake_form_completions' do
    post "/intake_form_completions", params: {"project_id"=>@project.id} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test 'DELETE /intake_form_completions' do
    delete "/intake_form_completions", params: {"project_id"=>@project.id} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
