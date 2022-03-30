module Area
  class Offer < Area::Base
    def self.root
      '/empty.html'
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
  end
end
 
