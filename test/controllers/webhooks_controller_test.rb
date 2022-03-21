require "test_helper"

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "typical POST to /webhook" do
    create(:project)
    post "/webhook", params: JSON.parse(File.read('./test/fixtures/files/webhook.json'))
    assert_equal "200", response.code
  end

  test "GET /webhook_signed_by_company" do
    create(:project, :has_envelope)
    get "/webhook_signed_by_company?envelope_id=testing&" \
        "original_url=aHR0cDovL3d3dy5leGFtcGxlLmNvbS9wcm9qZWN0cy8xL3VuZGVyd3JpdGluZ19wcmVwYXJlX3JlcGM=&" \
        "event=signing_complete"
    assert_equal "302", response.code
  end

  test "GET /webhook_revert" do
    create(:project)
    get "/webhook_revert"
    assert_equal "200", response.code
  end

  # when sendgrid notifies of unknown sg_message_id
  test 'POST /webhook_sendgrid_event' do
    project = create(:project)
    post '/webhook_sendgrid_event', env: { 'RAW_POST_DATA': [{
      "timestamp": 1513299569,
      "event": "click",
      "sg_message_id": "testing_sg_message_id",
    }].to_json }
    assert_nil project.reload.offer_viewed
  end

  # when sendgrid notifies of known sg_message_id
  test 'POST /webhook_sendgrid_event /2' do
    project = create(:project, sendgrid_message_id: 'testing_sg_message_id')
    post '/webhook_sendgrid_event', env: { 'RAW_POST_DATA': [{
      "timestamp": 1513299569,
      "event": "click",
      "sg_message_id": "testing_sg_message_id",
    }].to_json }
    assert_equal Time.at(1513299569), project.reload.offer_viewed
  end
end
