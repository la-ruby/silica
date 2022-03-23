# frozen_string_literal: true

class Project < ApplicationRecord
  include DocuSign::Mixin
  include PrettyDate
  include PrettyMoney
  include ProjectPresenter
  include Webflow
  include Docusignable
  include BuildInitialRecords
  include ProjectValidations
  include ProjectStateHelpers
  extend Search

  scope :listed, -> { joins(:listing).where("listings.listed = 'true'") }

  has_many :kodaks, dependent: :destroy
  has_one :property_disposition_checklist
  has_one :listing
  has_many :repcs
  has_one :intake_form
  has_many :addendums

  after_create :update_searchable_columns

  # rubocop: disable Metrics/AbcSize
  def update_searchable_columns
    str = "#{name} " \
          "#{street} #{street2} #{city} #{state} " \
          "#{phone} " \
          "#{email} " \
          "#{expectedtimeline} " \
          "#{begin
            req_date.strftime('%m/%d')
          rescue StandardError
            ''
          end} " \
          "#{begin
            Time.iso8601(repc.sent_homeowner_at).strftime('%m/%d')
          rescue StandardError
            ''
          end} " \
          "#{begin
            offer_viewed.strftime('%m/%d')
          rescue StandardError
            ''
          end} " \
          "#{begin
            accepted_at.strftime('%m/%d')
          rescue StandardError
            ''
          end} " \
          "#{begin
            addendum_sent.strftime('%m/%d')
          rescue StandardError
            ''
          end} " \
          "#{source}"
    update_columns(
      searchable: str,
      street_searchable: "#{street} #{street2} #{city} #{state}"
    )
  end

  def terms
    return if repc.offer_terms != 'yes'

    str = ''
    str += "Down Payment: $#{repc.down_payment}\n" if repc.down_payment.present?
    str += "Term Length: #{repc.term_length} mos\n" if repc.term_length.present?
    str += "Interest Rate: #{repc.interest_rate}%\n" if repc.interest_rate.present?
    str += "Monthly Payment: $#{repc.monthly_payment}\n" if repc.monthly_payment.present?
    str += "Balloon Payment: $#{repc.balloon_payment}\n" if repc.balloon_payment.present?
    str
  end
  # rubocop: enable Metrics/AbcSize

  def repc
    repcs.last
  end

  def add_addendum_button_available?
    result = true

    return false unless repc.mature?

    result
  end

  def dispositions_prepare_listing_term_details_editable?
    repc.offer_terms == 'yes'
  end

  def dual?
    secondName.present? && secondEmail.present?
  end

  def dual_for_testing!
    update!(secondName: 'Testing', secondEmail: 'testing@example.net', secondPhone: '(111) 123-4567')
  end

  def marketplace_kodaks
    kodaks.where(marketplace: '1')
  end

  def primary_or_first_kodak
    kodaks.where(primary: '1', marketplace: '1').first&.pic || kodaks.where(marketplace: '1').first&.pic
  end
end
