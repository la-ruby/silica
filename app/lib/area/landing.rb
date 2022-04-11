module Area
  # Devise login page for example
  class Landing < Area::Base
    def nav?
      false
    end

    def deprecated_font
      nil
    end

    def style(name)
      case name
      when :basic
        LandingBasicStyle
      end
    end

  end
end
 
