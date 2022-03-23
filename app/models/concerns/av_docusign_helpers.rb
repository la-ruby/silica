# frozen_string_literal: true

module AvDocusignHelpers
  extend ActiveSupport::Concern

  included do
    # creates envelpoe if it doesnt exist
    def docusign_envelope_id!
      update(docusign_envelope_id: make_envelope) unless docusign_envelope_id
      docusign_envelope_id
    end

    # rubocop: disable Metrics/AbcSize
    def make_envelope
      seller = addendum.project
      name = seller.name
      DocuSign::EnvelopeRequestAlternative.new.perform(
        second_seller_mode: seller.dual?,

        template_id: APOLLO_DOCUSIGN_ADDENDUM_TEMPLATE_ID,
        first_seller_name: name,
        first_seller_email: seller.email,
        second_seller_name: seller.secondName,
        second_seller_email: seller.secondEmail,

        address: seller.combined_address_with_zip,
        addendum_terms: (terms.presence || '-'),
        deadline_changes: begin
          apollo_date2(deadline)
        rescue StandardError
          '-'
        end,
        addendum_deadline_date: (apollo_date2(expiration) || '-'),
        addendum_deadline_time: apollo_date6(expiration),
        seller_name: selelr.name,
        offer_date: begin
          apollo_date2(related_repc.sent_homeowner_at)
        rescue StandardError
          '-'
        end,
        deadlines_changed: (deadline.present? ? 'true' : 'false')
      )
    end
    # rubocop: enable Metrics/AbcSize
  end
end
