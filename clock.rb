require 'clockwork'
require './config/boot'
require './config/environment'
require 'active_support/time' # Allow numeric durations (eg: 1.minutes)

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(5.minutes, 'fiveminutely.job', :skip_first_run => true) do
    DownloadEnvelopeStatusesJob.perform_later
  end

  every(5.minutes, 'webflow_push_job', :skip_first_run => true) do
    # WebflowPushJob.perform_later
  end

  every(1.day, 'cache_contact_count.job', :skip_first_run => true) do
    CacheContactCountJob.perform_later
  end
end
