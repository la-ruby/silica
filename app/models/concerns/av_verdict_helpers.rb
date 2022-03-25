# frozen_string_literal: true

module AvVerdictHelpers
  extend ActiveSupport::Concern

  included do
    def set_status_to_accepted_maybe
      if addendum.project.dual?
        update(status: 'Accepted') if accepted_at.present? && second_seller_accepted_at.present?
      elsif accepted_at.present?
        update(status: 'Accepted')
      end
      if addendum.project.dual?
        update(status: 'Rejected') if rejected_at.present? && second_seller_rejected_at.present?
      elsif rejected_at.present?
        update(status: 'Rejected')
      end
    end

    def accepted?
      if addendum.project.dual?
        accepted_at.present? && second_seller_accepted_at.present?
      else
        accepted_at.present?
      end
    end

    def rejected?
      if addendum.project.dual?
        rejected_at.present? && second_seller_rejected_at.present?
      else
        rejected_at.present?
      end
    end

    def accepted_by?(second_seller_mode)
      if second_seller_mode
        accepted_at.present? || second_seller_accepted_at.present?
      else
        accepted_at.present?
      end
    end

    def rejected_by?(second_seller_mode)
      if second_seller_mode
        rejected_at.present? || second_seller_rejected_at.present?
      else
        rejected_at.present?
      end
    end

    def is_accepted_or_rejected?
      derived_status == 'Accepted' || derived_status == 'Rejected'
    end
  end
end
