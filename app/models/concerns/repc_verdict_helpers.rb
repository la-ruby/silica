# frozen_string_literal: true

module RepcVerdictHelpers
  extend ActiveSupport::Concern

  included do
    def accepted?
      if project.dual?
        accepted_at.present? && second_seller_accepted_at.present?
      else
        accepted_at.present?
      end
    end

    def rejected?
      if project.dual?
        rejected_at.present? && second_seller_rejected_at.present?
      else
        rejected_at.present?
      end
    end

    def rejected_by?(second_seller_mode)
      if second_seller_mode
        second_seller_rejected_at.present?
      else
        rejected_at.present?
      end
    end
  end
end
