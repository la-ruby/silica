# frozen_string_literal: true

# Syncs to webflow
# :reek:DuplicateMethodCall
# :reek:UtilityFunction
class WebflowPushJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Project.listed.patchable.map(&:send_update_to_webflow)
    Project.listed.postable.map(&:send_to_webflow)
    nil
  end
end
