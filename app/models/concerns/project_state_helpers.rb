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

    def two_letter_state
      if utah?
        'UT'
      elsif north_carolina?
        'NC'
      else
        state[0..1]
      end
    end
  end
end
