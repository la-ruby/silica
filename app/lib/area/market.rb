module Area
  class Market < Area::Base
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
  end
end
 
