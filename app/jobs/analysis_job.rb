# frozen_string_literal: true

class AnalysisJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    5.times do
      Rails.logger.info "Working"
      sleep 1
    end
    true
  end
end
