module ProjectStateHelpers
  extend ActiveSupport::Concern

  included do
    def utah?
      state =~ /Utah/i || state =~ /\AUT/
    end
    
    def north_carolina?
      state =~ /North Carolina/i || state =~/\ANC/
    end
    
    def detected_state
      if utah?
        'Utah'
      elsif north_carolina?
        'NC'
      else
        nil
      end
    end
  end
end
