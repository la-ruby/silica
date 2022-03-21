module AvVerdictHelpers
  extend ActiveSupport::Concern

  included do

    def set_status_to_accepted_maybe
      if addendum.project.dual?
        if accepted_at.present? && second_seller_accepted_at.present?
          update(status: 'Accepted')
        end
      else
        update(status: 'Accepted') if accepted_at.present?
      end
      if addendum.project.dual?
        if rejected_at.present? && second_seller_rejected_at.present?
          update(status: 'Rejected')
        end
      else
        update(status: 'Rejected') if rejected_at.present?
      end
    end

    def accepted?
      if addendum.project.dual?
        if accepted_at.present? && second_seller_accepted_at.present?
          return true
        else
          return false
        end
      else
        if accepted_at.present?
          return true
        else
          return false
        end
      end
    end

    def rejected?
      if addendum.project.dual?
        if rejected_at.present? && second_seller_rejected_at.present?
          return true
        else
          return false
        end
      else
        if rejected_at.present?
          return true
        else
          return false
        end
      end
    end

    def accepted_by?(second_seller_mode)
      if second_seller_mode
        if accepted_at.present? || second_seller_accepted_at.present?
          true
        else
          false
        end
      else
        accepted_at.present?
      end
    end

    def rejected_by?(second_seller_mode)
      if second_seller_mode
        if rejected_at.present? || second_seller_rejected_at.present?
          true
        else
          false
        end
      else
        rejected_at.present?
      end
    end

    def is_accepted_or_rejected?
      derived_status == 'Accepted' || derived_status == 'Rejected'
    end
  end
end
