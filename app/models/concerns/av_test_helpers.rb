# frozen_string_literal: true

# Av Test module
module AvTestHelpers
  extend ActiveSupport::Concern

  included do
    def reject_for_testing!
      update_column(:rejected_at, Time.now.iso8601)
      update_column(:second_seller_rejected_at, Time.now.iso8601) if addendum.project.dual?
    end

    def accept_for_testing!
      update_column(:accepted_at, Time.now.iso8601)
      update_column(:second_seller_accepted_at, Time.now.iso8601) if addendum.project.dual?
    end
  end
end
