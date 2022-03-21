require "test_helper"

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project, :has_av)
    sign_in create(:user)
  end

  test "GET /offer-addendum/hex/feedback/new" do
    get "/offer-addendum/#{@project.addendums.last.addendum_versions.last.mop_token}/feedback/new"
    assert_equal "200", response.code
  end

  test 'POST /feedbacks' do
    post '/feedbacks', params: {"token"=>@project.addendums.last.addendum_versions.last.mop_token, "rejected_feedback"=>"aaa"}, headers: { "HTTP_REFERER": "/testing", accept: Mime[:turbo_stream].to_s }
    assert_equal "302", response.code
  end
end
