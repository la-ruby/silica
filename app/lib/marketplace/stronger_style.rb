# frozen_string_literal: true

module Marketplace
  class StrongerStyle
    def self.inline_css
      arr = []
      arr.push("color: #{Setting.marketplace_stronger_style_color}") if Setting.marketplace_stronger_style_color.present?
      arr.join('; ')
    end

    def self.css
      [
        Setting.marketplace_stronger_style_size,
        Setting.marketplace_stronger_style_weight,
        Setting.marketplace_stronger_style_face
      ].compact.join(' ')
    end
  end
end
