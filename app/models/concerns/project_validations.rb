# frozen_string_literal: true

module ProjectValidations
  extend ActiveSupport::Concern

  included do
    validates :street, presence: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    validates :secondEmail, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true
    validate :phone_has_at_least_ten_digits
    validate :second_phone_has_at_least_ten_digits

    def phone_has_at_least_ten_digits
      if phone.present? && ((phone.scan(/\d/).size < 10) || (phone.scan(/\d/).size > 11))
        errors.add(:phone, 'invalid (need 10 or 11 digits)')
      end
    end

    def second_phone_has_at_least_ten_digits
      if secondPhone.present? && ((secondPhone.scan(/\d/).size < 10) || (secondPhone.scan(/\d/).size > 11))
        errors.add(:secondPhone, 'invalid (need 10 or 11 digits)')
      end
    end
  end
end
