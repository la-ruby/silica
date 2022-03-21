module AvDocusignHelpers
  extend ActiveSupport::Concern

  included do
    # creates envelpoe if it doesnt exist
    def docusign_envelope_id!
      unless docusign_envelope_id
        update(docusign_envelope_id: make_envelope)
      end
      docusign_envelope_id
    end

    def make_envelope
      DocuSign::EnvelopeRequestAlternative.new.perform(
        second_seller_mode: addendum.project.dual?,

        template_id: APOLLO_DOCUSIGN_ADDENDUM_TEMPLATE_ID,
        first_seller_name: addendum.project.name,
        first_seller_email: addendum.project.email,
        second_seller_name: addendum.project.secondName,
        second_seller_email: addendum.project.secondEmail,

        address: addendum.project.combined_address_with_zip,
        addendum_terms: (terms.presence || '-'),
        deadline_changes: (apollo_date2(deadline) rescue '-'),
        addendum_deadline_date: (apollo_date2(expiration) || '-'),
        addendum_deadline_time: apollo_date6(expiration),
        seller_name: addendum.project.name,
        offer_date: (apollo_date2(related_repc.sent_homeowner_at) rescue '-'),
        deadlines_changed: (deadline.present? ? 'true' : 'false')
      )
    end
  end
end
