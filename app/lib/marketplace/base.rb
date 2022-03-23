# frozen_string_literal: true

module Marketplace
  class Base
    def self.inline_css
      arr = []
      arr.push("background-color: #{Setting.marketplace_background_color} !important") if Setting.marketplace_background_color.present?
      arr.join('; ')
    end

    def self.css
      [
        Setting.marketplace_face,
        Setting.marketplace_weight
      ].compact.join(' ')
    end
  end
end
