# frozen_string_literal: true

# Syncs to webflow
# :reek:DuplicateMethodCall
# :reek:UtilityFunction
class WebflowPushJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Project.listed.map(&:send_to_webflow)
    nil
  end
end
