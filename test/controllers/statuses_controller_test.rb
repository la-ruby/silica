require "test_helper"

class StatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  ['statusOpen', 'statusCompletedClosedLost', 'statusCompletedWon'].each do |item|
    test "PATCH /statuses #{item}" do
      patch "/statuses", params: {"authenticity_token"=>"[FILTERED]", "project_id"=>@project.id, "button"=>item}, headers: { accept: Mime[:turbo_stream].to_s }
      assert_equal "200", response.code
    end
  end
end
