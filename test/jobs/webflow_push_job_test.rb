require "test_helper"

class WebflowPushJobTest < ActiveJob::TestCase
  # does post
  test "#perform" do
    create(:project, :has_listed)
    stub_request(:post, "https://api.webflow.com/collections/#{WEBFLOW_COLLECTION}/items").
      to_return(status: 200, body: '{}', headers: {})
    WebflowPushJob.perform_now
  end

  # does patch
  test "#perform /2" do
    create(:project, :has_listed, :has_webflow_id)
    stub_request(:post, "https://api.webflow.com/collections/#{WEBFLOW_COLLECTION}/items").
      to_return(status: 200, body: '{}', headers: {})
    stub_request(:delete, "https://api.webflow.com/collections/testing-collection/items/testing").
      to_return(status: 200, body: '{}', headers: {})
    WebflowPushJob.perform_now
  end
end

