# frozen_string_literal: true

module Area
  class Mbo
    def nav
      '/nav/nav'
    end

    def title
      "#{COMPANY_LC}. - My Offer Portal"
    end

    def menu_mode
      'mop'
    end

    def poppins?
      true
    end

    def footer?
      false
    end

    def root
      '/empty.html'
    end
  end
end
