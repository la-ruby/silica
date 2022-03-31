# frozen_string_literal: true

class AnalysisJob < ApplicationJob
  queue_as :default

  def perform(project)
    url = nil

    # download
    uri = URI.parse(CHART_SERVICE_HOST)
    req = Net::HTTP.new(uri.hostname, uri.port)
    req.use_ssl = true
    req.read_timeout = 120000
    Rails.logger.info ">> #{CHART_SERVICE_HOST}"
    res = req.post(
      uri.path,
      AnalysisXml.new(project).xml,
      {
        'Content-Type' => 'application/xml',
        "Accept" => "application/xml" })
    Rails.logger.info "<< res.body[0..76]}"
    url = Hash.from_xml(res.body).dig('avmx','response', 'reportdata', 'pdf', 'pdfLink')
    # /download
    project.update(analysis_url: url)
    project.update(analysis_at: Time.now.iso8601)
    true
  end
end
