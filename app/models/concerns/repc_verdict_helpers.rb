module RepcVerdictHelpers
  extend ActiveSupport::Concern

  included do
    def accepted?
      if project.dual?
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
      if project.dual?
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

    def rejected_by?(second_seller_mode)
      if second_seller_mode
        if second_seller_rejected_at.present?
          true
        else
          false
        end
      else
        rejected_at.present?
      end
    end
  end
end
