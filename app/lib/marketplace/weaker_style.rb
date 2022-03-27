# frozen_string_literal: true

module Marketplace
  # Marketplace WeakerStyle
  class WeakerStyle
    def self.inline_css
      arr = []
      arr.push("color: #{Setting.marketplace_weaker_style_color}") if Setting.marketplace_weaker_style_color.present?
      arr.join('; ')
    end

    def self.css
      [
        Setting.marketplace_weaker_style_size,
        Setting.marketplace_weaker_style_weight,
        Setting.marketplace_weaker_style_face
      ].compact.join(' ')
    end
  end
end
