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
  end
end
