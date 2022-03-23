# frozen_string_literal: true

# The RepcDocusignHelpers module
module RepcDocusignHelpers
  extend ActiveSupport::Concern

  included do
    # creates envelpoe if it doesnt exist
    def docusign_envelope_id!
      update(docusign_envelope_id: make_envelope) unless docusign_envelope_id
      docusign_envelope_id
    end

    # rubocop: disable Metrics/AbcSize
    def make_envelope
      seller = project
      DocuSign::EnvelopeRequest.new.perform(
        second_seller_mode: project.dual?,
        template_id: repc_template_id,
        first_seller_name: project.name,
        first_seller_email: project.email,
        second_seller_name: project.secondName,
        second_seller_email: project.secondEmail,
        real_estate_professional: real_estate_professional,
        closing_costs_paid_by: closing_costs_paid_by,
        purchase_price: purchase_price_pretty,
        seller_name: seller.name,
        seller_email: seller.email,
        seller_phone: seller.phone,
        second_name: seller.secondName,
        second_email: seller.secondEmail,
        second_phone: seller.secondPhone,
        address: project.combined_address_with_zip,
        earnest_money: earnest_money,
        agreement_date: apollo_date2(agreement_date),
        settlement_date: apollo_date2(settlement_date),
        inspection_period_date: apollo_date2(inspection_period_deadline),
        possession_date: apollo_date2(possession_date),
        additional_payment_terms: (project.terms || 'N/A'),
        notes: notes,
        legal_description: (legal_description.presence || '-'),
        title_company: (title_company.presence || '-')
      )
    end
    # rubocop: enable Metrics/AbcSize

    def repc_template_id
      project.secondName.present? ? DOCU_SIGN_REPC_TEMPLATE_DUAL : DOCU_SIGN_REPC_TEMPLATE
    end
  end
end
