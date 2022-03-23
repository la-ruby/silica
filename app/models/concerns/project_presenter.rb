# frozen_string_literal: true

# The ProjectPresenter module
module ProjectPresenter
  extend ActiveSupport::Concern

  included do
    def combined_address
      if street2.present?
        "#{street}, #{street2}, #{city} #{state}"
      else
        "#{street} #{city} #{state}"
      end
    end

    def combined_address_with_zip
      street2.present? ? "#{street}, #{street2}, #{city} #{state} #{zip}" : "#{street} #{city} #{state} #{zip}"
    end

    def pretty_phone
      class >> self 
        arr = phone.scan(/\d/)
        "#{arr[-11]}(#{arr[-10]}#{arr[-9]}#{arr[-8]}) #{arr[-7]}#{arr[-6]}#{arr[-5]}-#{arr[-4]}#{arr[-3]}#{arr[-2]}#{arr[-1]}"
      end
    end
  end
end
