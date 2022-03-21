module Marketplace
  class BasicStyle
    def self.inline_css
      arr = []
      arr.push("color: #{Setting.marketplace_basic_style_color}") if Setting.marketplace_basic_style_color.present?
      arr.join('; ')
    end

    def self.css
      [
        Setting.marketplace_basic_style_size,
        Setting.marketplace_basic_style_weight,
        Setting.marketplace_basic_style_face,
      ].compact.join(' ')
    end
  end
end
