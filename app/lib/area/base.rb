module Area
  class Base
    def nav?
      true
    end

    def footer?
      false
    end

    def logo_link
      '/'
    end

    def small_logo
      '/logo.png'
    end

    def logo
      '/logo.png'
    end

    # devisable areas show a login link
    def devisable?
      false
    end

    def menu_items
      []
    end

    def title
      "#{COMPANY_LC}"
    end

    def deprecated_font
      "brand-font"
    end

    def body_style
      nil
    end
  end
end
