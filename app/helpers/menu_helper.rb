# frozen_string_literal: true

module MenuHelper
  def infer_menu_items(menu_mode)
    case menu_mode
    when 'backend'
      [
        { label: 'My Dashboard', feather_icon: 'layout', link: 'https://example.com', allowed: false },
        { label: 'Project Table', feather_icon: 'clipboard', link: '/projects', allowed: true },
        { label: 'Calendar', feather_icon: 'calendar', link: 'https://example.com', allowed: false },
        { label: 'Deals', feather_icon: 'home', link: 'https://example.com', allowed: false }
      ]
    when 'marketplace'
      [
        { label: 'About Us', feather_icon: nil, link: "https://www.#{APOLLO_MARKETPLACE_NAKED_DOM}/company-pages/about",
          allowed: true },
        { label: 'Locations', feather_icon: nil, link: "https://www.#{APOLLO_MARKETPLACE_NAKED_DOM}/locations",
          allowed: true },
        { label: 'Resources', feather_icon: nil,
          link: "https://www.#{APOLLO_MARKETPLACE_NAKED_DOM}/blog-pages/resource-center", allowed: true },
        { label: 'FAQ', feather_icon: nil, link: "https://www.#{APOLLO_MARKETPLACE_NAKED_DOM}/faqs", allowed: true }
      ]
    else # if menu_mode == 'mop'
      []
    end
  end

  def infer_should_show_offcanvas(menu_mode)
    menu_mode != 'mop'
  end

  def allow_session_buttons(menu_mode)
    menu_mode != 'mop'
  end
end
