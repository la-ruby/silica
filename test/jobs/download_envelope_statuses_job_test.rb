require "test_helper"

class DownloadEnvelopeStatusesJobTest < ActiveJob::TestCase
  setup do
    @project = create(:project, :has_envelope)
  end

  test "#perform_now" do
    travel_to APOLLO_EPOCH
    stub_docusign_token_request
    stub_docusign_status_request
    DownloadEnvelopeStatusesJob.perform_now
    travel_back
  end

  test "#perform_now hasUnknownRepc" do
    travel_to APOLLO_EPOCH
    stub_docusign_token_request
    stub_docusign_status_request
    @project.repc.update(docusign_envelope_id: "+_*&^%$#@!~")
    DownloadEnvelopeStatusesJob.perform_now
    travel_back
  end
end

