require "test_helper"

class CacheContactCountJobTest < ActiveJob::TestCase
  test "#perform" do
    stub_sendgrid_marketing_lists
    CacheContactCountJob.perform_now
  end
end

