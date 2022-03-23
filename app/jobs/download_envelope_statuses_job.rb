# frozen_string_literal: true

class DownloadEnvelopeStatusesJob < ApplicationJob
  queue_as :default

  # rubocop: disable Metrics/AbcSize
  def perform(*_args)
    DocuSign::EnvelopesStatusRequest.new.perform.each do |result|
      Rails.logger.info "Iterating envelopeId #{result.envelope_id} status #{result.status} completedDateTime #{result.status_changed_date_time}"
      repc = Repc.find_by_docusign_envelope_id(result.envelope_id)
      unless repc
        Rails.logger.info "skip unknown #{result.envelope_id}"
        next
      end
      repc.project.update(accepted_at: result.status_changed_date_time) unless APOLLO_INTERNAL_PRODUCTION
      Rails.logger.info "Detected acceptance at #{result.status_changed_date_time} for project #{repc.project.id} repc #{repc.id}" unless APOLLO_INTERNAL_PRODUCTION
    end
  end
  # rubocop: enable Metrics/AbcSize
end
