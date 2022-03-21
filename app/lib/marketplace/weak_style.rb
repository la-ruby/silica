module Marketplace
  class WeakStyle
    def self.inline_css
      arr = []
      arr.push("color: #{Setting.marketplace_weak_style_color}") if Setting.marketplace_weak_style_color.present?
      arr.join('; ')
    end

    def self.css
      [
        Setting.marketplace_weak_style_size,
        Setting.marketplace_weak_style_weight,
        Setting.marketplace_weak_style_face,
      ].compact.join(' ')
    end
  end
end
