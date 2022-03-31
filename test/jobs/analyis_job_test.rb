require "test_helper"

class AnalyisJobTest < ActiveJob::TestCase
  test "#perform" do
    xml = '<avmx><response><reportdata><pdf>' \
          '<pdfLink>https://example.com/testing</pdfLink></pdf>' \
          '</reportdata></response></avmx>'
    stub_request(:post, 'https://example.com/testing_path').
       to_return(status: 200, body: xml, headers: {})
    AnalysisJob.perform_now( create(:project) )
  end
end

