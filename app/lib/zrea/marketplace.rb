module Zrea
  # aka listings
  class Marketplace
    def root
      '/listings'
    end

    def title
      "#{COMPANY_LC}. - Marketplace"
    end

    def menu_mode
      'marketplace'
    end

    def poppins?
      false
    end

    def nav
      '/nav/nav'
    end

    def footer?
      false
    end
  end
end

