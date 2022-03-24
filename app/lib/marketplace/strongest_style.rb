# frozen_string_literal: true

module Marketplace
  class StrongestStyle
    def self.inline_css
      arr = []
      if Setting.marketplace_strongest_style_color.present?
        arr.push("color: #{Setting.marketplace_strongest_style_color}")
      end
      arr.join('; ')
    end

    def self.css
      [
        Setting.marketplace_strongest_style_size,
        Setting.marketplace_strongest_style_weight,
        Setting.marketplace_strongest_style_face
      ].compact.join(' ')
    end
  end
end
