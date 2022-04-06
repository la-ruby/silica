module Area
  class Market < Area::Base
    def self.root
      '/listings'
    end

    def style(name)
      case name
      when :basic
        MarketBasicStyle
      end
    end

    def title
      "#{COMPANY_LC}. - Marketplace"
    end

    def logo_link
      '/listings'
    end

    def small_logo
      '/logos/marketplace.png'
    end

    def logo
      '/logos/marketplace.png'
    end

    def menu_items
      [
	{ label: 'About Us', feather_icon: nil, link: "https://www.#{APOLLO_MARKETPLACE_NAKED_DOM}/company-pages/about", allowed: true },
	{ label: 'Locations', feather_icon: nil, link: "https://www.#{APOLLO_MARKETPLACE_NAKED_DOM}/locations", allowed: true },
	{ label: 'Resources', feather_icon: nil, link: "https://www.#{APOLLO_MARKETPLACE_NAKED_DOM}/blog-pages/resource-center", allowed: true },
	{ label: 'FAQ', feather_icon: nil, link: "https://www.#{APOLLO_MARKETPLACE_NAKED_DOM}/faqs", allowed: true },
      ]
    end

    def deprecated_font
      "brand-font-2"
    end

    def nav_bg
      'bg_f9'
    end

    def nav_item_style
      "fs-5"
    end

    # def background_style
    #   'apollo-bg-white-3-i'
    # end

    def high_background_style
      'apollo-bg-white-4-i'
    end
  end
end
 
