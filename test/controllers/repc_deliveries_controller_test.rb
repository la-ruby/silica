require "test_helper"

class RepcDeliveriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test "POST /repc_deliveries" do
    @project.dual_for_testing!
    stub_request(:post, "https://api.sendgrid.com/v3/mail/send").
      to_return(status: 200, body: "", headers: {'x-message-id'=>'example'})

    stub_request(:post, "https://api.sendgrid.com/v3/mail/send").
      to_return(status: 200, body: "", headers: {'x-message-id'=>'example'})


    post "/repc_deliveries", params: {"repc_delivery"=>{"project_id"=>@project.id, "repc_id"=>@project.repcs.last.id}}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
