# frozen_string_literal: true

module Area
  class Backend
    def nav
      '/nav/nav'
    end

    def title
      "#{COMPANY_LC}. - Backend"
    end

    def menu_mode
      'backend'
    end

    def poppins?
      false
    end

    def footer?
      true
    end

    def root
      '/projects'
    end
  end
end
