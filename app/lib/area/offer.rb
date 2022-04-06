module Area
  class Offer < Area::Base
    def self.root
      '/empty.html'
    end

    def style(name)
      case name
      when :basic
        OfferBasicStyle
      end
    end

    def title
      "#{COMPANY_LC}. - My Offer Portal"
    end

    def logo_link
      '#'
    end

    def logo
      '/mbo/logo.png'
    end

    def nav_bg
      'apollo-bg-white-4'
    end

    def body_style
      'silica-house-background'
    end

    def low_background_style
      'apollo-bg-white-2'
    end
    
    def background_style
      'apollo-bg-white-3-i'
    end

    # def high_background_style
    #   'apollo-bg-white-4-i'
    # end
  end
end
 
