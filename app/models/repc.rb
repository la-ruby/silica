# frozen_string_literal: true

# Repc Model
class Repc < ApplicationRecord
  include PrettyDate
  include RepcVerdictHelpers
  include RepcDocusignHelpers

  belongs_to :project

  def second_seller_mop_token
    "#{mop_token}f"
  end

  def can_leave_feedback?(second_seller_mode)
    return true if second_seller_mode && !second_seller_rejected_feedback.present?
    return true if !second_seller_mode && !rejected_feedback.present?
  end

  def accepted_by?(second_seller_mode)
    if second_seller_mode
      second_seller_accepted_at.present?
    else
      accepted_at.present?
    end
  end

  def mature?
    sent_homeowner_at.present? && signed_by_company_at.present?
  end

  def mature_ish?
    sent_homeowner_at.present? || signed_by_company_at.present? || (mutable != '1')
  end

  def mature_for_testing!
    update(sent_homeowner_at: Time.now.iso8601,
           signed_by_company_at: Time.now.iso8601)
  end

  def purchase_price
    offer_arv_ = field_to_f(company_offer_arv)
    service_fee_ = field_to_f(service_fee)
    service_fee__ = (service_fee_is_percentage == 'true' ? (offer_arv_ / 100 * service_fee_) : service_fee_)
    sum = offer_arv_ - service_fee__ - field_to_f(repair_costs) - field_to_f(closing_costs)
    format('%.2f', sum)
  end

  def my_offer_portal_shows_addendum_card?
    project.addendums.present? &&
      project.addendums.last.addendum_versions.present? &&
      project.addendums.last.addendum_versions.last.signed_by_company_at.present? &&
      project.addendums.last.addendum_versions.last.sent_to_seller_at.present?
  end

  def purchase_price_pretty
    return '0' unless purchase_price.present?

    ActiveSupport::NumberHelper.number_to_delimited(purchase_price)
  end

  private

  def field_to_f(field)
    field.to_f
  rescue StandardError
    0.0
  end
end
