# frozen_string_literal: true

class AddendumVersion < ApplicationRecord
  include PrettyDate
  include AvTestHelpers
  include AvDocusignHelpers
  include AvVerdictHelpers

  belongs_to :addendum

  validates :status, inclusion: { in: [ 'Ready', 'Sent', 'Accepted', 'Rejected', 'Draft', 'Signed', 'Sent' ] }

  def is_editable?
    !signed_by_company_at.present? && !sent_to_seller_at.present?
  end

  def second_seller_mop_token
    "#{mop_token}f"
  end

  def can_leave_feedback?(second_seller_mode)
    return true if second_seller_mode && !second_seller_rejected_feedback.present?
    return true if !second_seller_mode && !rejected_feedback.present?
  end

  def related_repc
    Repc.find(related_repc_id)
  end

  def discarded?
    version != addendum.addendum_versions.order(:version).last.version
  end

  def discard_button_disabled?
    (is_accepted_or_rejected? || !related_repc.mature?)
  end

  def sign_button_disabled?
    ["Accepted", "Rejected"].include?(derived_status) || signed_by_company_at.present? || !related_repc.mature?
  end

  def send_to_seller_button_disabled?
    ["Accepted", "Rejected"].include?(derived_status) || !signed_by_company_at.present? || !related_repc.mature?
  end

  def derived_status
    result = 'Draft'
    return 'Discarded' if discarded?
    return 'Accepted' if accepted?
    return 'Rejected' if rejected?
    return 'Sent' if sent_to_seller_at.present?
    return 'Signed' if signed_by_company_at.present?

    result
  end

  def silica_dom_id
    "addendum-#{addendum.id}-addendum-version-#{id}-panel"
  end
end
