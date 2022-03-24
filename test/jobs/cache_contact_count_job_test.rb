require "test_helper"

class CacheContactCountJobTest < ActiveJob::TestCase
  test "#perform" do
    stub_request(:get, 'https://api.sendgrid.com/v3/marketing/lists')
      .to_return(status: 200, body: {
                   result: [
                     { id: 'bc6acbc2-b12c-49d8-beee-31fc9908ba4b' } ]
                 }.to_json, headers: {})
    CacheContactCountJob.perform_now
  end
end

