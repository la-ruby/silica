module Docusignable
  extend ActiveSupport::Concern

  included do
    def create_docusign_envelope(repc_id)
      repc = Repc.find(repc_id)
      envelope_id = repc.docusign_envelope_id!
      original_url = Base64.urlsafe_encode64("#{APOLLO_BACKEND_FULL_DOMAIN}/projects/#{id}/underwriting_prepare_repc")
      url = create_recipient_view(
        envelope_id: envelope_id,
        return_url: "#{APOLLO_BACKEND_FULL_DOMAIN}/webhook_signed_by_company?envelope_id=#{envelope_id}&original_url=#{original_url}",
        role: :staff,
        name: APOLLO_PURCHASER_NAME,
        email: APOLLO_PURCHASER_EMAIL
      )
      encoded = Base64.encode64("#{APOLLO_BACKEND_FULL_DOMAIN}/webhook_signed_by_company?envelope_id=#{envelope_id}&original_url=#{original_url}")
      url = "#{APOLLO_CDN}/bounceV10.html?a=#{encoded}" if APOLLO_INTERNAL_PRODUCTION
      url
    end

    def create_docusign_envelope_for_addendum_version(addendum_version_id)
      addendum_version = ::AddendumVersion.find(addendum_version_id)
      project = addendum_version.addendum.project
      envelope_id = addendum_version.docusign_envelope_id!
      original_url = Base64.urlsafe_encode64("#{APOLLO_BACKEND_FULL_DOMAIN}/projects/#{project.id}/underwriting_review_offer")
      url = create_recipient_view(
        envelope_id: envelope_id,
        return_url: "#{APOLLO_BACKEND_FULL_DOMAIN}/webhook_signed_by_company?envelope_id=#{envelope_id}&original_url=#{original_url}",
        role: :staff,
        name: APOLLO_PURCHASER_NAME,
        email: APOLLO_PURCHASER_EMAIL
      )

      encoded = Base64.encode64("#{APOLLO_BACKEND_FULL_DOMAIN}/webhook_signed_by_company?envelope_id=#{envelope_id}&original_url=#{original_url}")
      url = "#{APOLLO_CDN}/bounceV10.html?a=#{encoded}" if APOLLO_INTERNAL_PRODUCTION
      url
    end
  end
end
