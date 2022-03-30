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

  test 'get /offer/:mop_token/feedback' do
    project = create(:project)
    get "/offer/#{project.repc.mop_token}/feedback"
    assert_equal "200", response.code
  end

  test 'get /offer/:mop_token/feedback for second seller' do
    project = create(:project)
    get "/offer/#{project.repc.second_seller_mop_token}/feedback"
    assert_equal "200", response.code
  end

  test 'get /offer-addendum/:mop_token/feedback' do
    project = create(:project, :has_av)
    get "/offer-addendum/#{project.addendums.last.addendum_versions.last.mop_token}/feedback"
    assert_equal "200", response.code
  end

  test 'get /offer-addendum/:mop_token/feedback as second seller' do
    project = create(:project, :has_av)
    get "/offer-addendum/#{project.addendums.last.addendum_versions.last.second_seller_mop_token}/feedback"
    assert_equal "200", response.code
  end
end
