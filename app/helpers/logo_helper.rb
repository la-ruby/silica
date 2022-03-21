# frozen_string_literal: true

# :nodoc:
module LogoHelper
  def infer_logo_link(menu_mode)
    case menu_mode
    when 'marketplace'
      '/listings'
    when 'mop'
      '#'
    else
      '/'
    end
  end

  def infer_logo(menu_mode)
    case menu_mode
    when 'marketplace'
      silica_bucket('/logos/marketplace.png', brand: COMPANY_LC)
    when 'mop'
      silica_bucket('/mbo/logo.png', brand: COMPANY_LC)
    else
      silica_bucket('/logo.png', brand: COMPANY_LC)
    end
  end

  def infer_small_logo(menu_mode)
    case menu_mode
    when 'marketplace'
      silica_bucket('/logos/marketplace.png', brand: COMPANY_LC)
    else
      silica_bucket('/logo.png', brand: COMPANY_LC)
    end
  end
end
