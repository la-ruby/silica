module Area
  class Backend < Area::Base
    def self.root
      '/projects'
    end

    def style(name)
      case name
      when :basic
        BackendBasicStyle
      end
    end

    def title
      "#{COMPANY_LC}. - Backend"
    end

    def footer?
      true
    end

    def devisable?
      true
    end

    def menu_items
      [
	{ label: 'My Dashboard', feather_icon: 'layout', link: 'https://example.com', allowed: false },
	{ label: 'Project Table', feather_icon: 'clipboard', link: '/projects', allowed: true },
	{ label: 'Calendar', feather_icon: 'calendar', link: 'https://example.com', allowed: false },
	{ label: 'Deals', feather_icon: 'home', link: 'https://example.com', allowed: false },
      ]
    end

    def deprecated_font
      "tailwind-font"
    end

    def nav_bg
      'apollo-bg-white-4'
    end
  end
end
 
