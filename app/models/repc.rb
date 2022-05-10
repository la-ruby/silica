# frozen_string_literal: true

class Repc < ApplicationRecord
  include PrettyDate
  include RepcVerdictHelpers
  include RepcDocusignHelpers

  belongs_to :project

  after_update :activity_tab_updates

  def activity_tab_updates
    if silica_attribute_added?('signed_by_company_at', previous_changes)
      Event.create(
        category: 'repc_signed',
        timestamp: Time.parse(signed_by_company_at),
        record_id: project.id,
        record_type: 'Project',
        inventor_id: -2)
    end

    if silica_attribute_added?('accepted_at', previous_changes)
      Event.create(
        category: 'repc_signed_by_seller',
        timestamp: Time.parse(accepted_at),
        record_id: project.id,
        record_type: 'Project',
        inventor_id: -3)
    end

    if silica_attribute_added?('second_seller_accepted_at', previous_changes)
      Event.create(
        category: 'repc_signed_by_seller',
        timestamp: Time.parse(second_seller_accepted_at),
        record_id: project.id,
        record_type: 'Project',
        inventor_id: -4)
    end
  end

  def silica_attribute_added?(the_attribute, the_previous_changes)
    if the_previous_changes.has_key?(the_attribute) &&
       (!(the_previous_changes[the_attribute][0].blank? && the_previous_changes[the_attribute][1].blank?)) && # change from nil to "" doesnt count
       the_previous_changes[the_attribute][0].blank? && the_previous_changes[the_attribute][1].present?
      true
    end
  end

  def second_seller_mop_token
    "#{mop_token}f"
  end

  def can_leave_feedback?(second_seller_mode)
    return true if second_seller_mode && !second_seller_rejected_feedback.present?
    return true if !second_seller_mode && !rejected_feedback.present?
  end

  def accepted_by?(second_seller_mode)
    if second_seller_mode
      if second_seller_accepted_at.present?
        true
      else
        false
      end
    else
      accepted_at.present?
    end
  end

  def mature?
    sent_homeowner_at.present? && signed_by_company_at.present?
  end

  def mature_ish?
    sent_homeowner_at.present? || signed_by_company_at.present? || (mutable != "1")
  end

  def mature_for_testing!
    update(sent_homeowner_at: Time.now.iso8601,
           signed_by_company_at: Time.now.iso8601)
  end

  def purchase_price
    offer_arv_ = (company_offer_arv.to_f rescue 0.0)
    service_fee_ = (service_fee.to_f rescue 0.0)
    service_fee__ = (service_fee_is_percentage == 'true' ? (offer_arv_ /100 * service_fee_) : service_fee_)
    repair_costs_ = (repair_costs.to_f rescue 0.0)
    closing_costs_ = (closing_costs.to_f rescue 0.0)
    sum = offer_arv_ - service_fee__ - repair_costs_ - closing_costs_
    sprintf("%.2f", sum)
  end

  def my_offer_portal_shows_addendum_card?
    result = project.addendums.present? &&
      project.addendums.last.addendum_versions.present? &&
      project.addendums.last.addendum_versions.last.signed_by_company_at.present? &&
      project.addendums.last.addendum_versions.last.sent_to_seller_at.present?
    result
  end

  def purchase_price_pretty
    return '0' unless purchase_price.present?

    ActiveSupport::NumberHelper.number_to_delimited(purchase_price)
  end
end
