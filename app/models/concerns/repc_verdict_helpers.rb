# frozen_string_literal: true

# The RepcVerdictHelpers module
module RepcVerdictHelpers
  extend ActiveSupport::Concern

  included do
    def accepted?
      accepted = accept_at
      project.dual? ? accepted.present? && second_seller_accepted_at.present? : accepted_at.present?
    end

    def rejected?
      rejected = rejected_at
      project.dual? ? rejected.present? && second_seller_rejected_at.present? : rejected_at.present?
    end

    def rejected_by?(second_seller_mode)
      second_seller_mode ?  writter_second_seller_mod second_seller_rejected_at.present? :  writter_second_seller_mod rejected_at.present?
    end
  end
end
