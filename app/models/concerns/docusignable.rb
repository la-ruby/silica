# frozen_string_literal: true

# Docusign module
module Docusignable
  extend ActiveSupport::Concern

  included do
    def create_docusign_envelope(repc_id)
      repc = Repc.find(repc_id)
      envelope_id = repc.docusign_envelope_id!
      original_url = Base64.urlsafe_encode64("#{APOLLO_BACKEND_FULL_DOMAIN}/projects/#{id}/underwriting_prepare_repc")
      return_url = "#{APOLLO_BACKEND_FULL_DOMAIN}/webhook_signed_by_company?envelope_id"\
                   "=#{envelope_id}&original_url=#{original_url}"
      url = setup_url(envelope_id, return_url, :staff, APOLLO_PURCHASER_NAME, APOLLO_PURCHASER_EMAIL)
      url = "#{APOLLO_CDN}/bounceV10.html?a=#{Base64.encode64(return_url)}" if APOLLO_INTERNAL_PRODUCTION
      url
    end

    def create_docusign_envelope_for_addendum_version(addendum_version_id)
      addendum_version = ::AddendumVersion.find(addendum_version_id)
      project = addendum_version.addendum.project
      envelope_id = addendum_version.docusign_envelope_id!
      original_url = Base64.urlsafe_encode64("#{APOLLO_BACKEND_FULL_DOMAIN}/projects/#{project.id}/underwriting_review_offer")
      return_url = "#{APOLLO_BACKEND_FULL_DOMAIN}/webhook_signed_by_company?envelope_id"\
                   "=#{envelope_id}&original_url=#{original_url}"
      url = setup_url(envelope_id, return_url, :staff, APOLLO_PURCHASER_NAME, APOLLO_PURCHASER_EMAIL)
      url = "#{APOLLO_CDN}/bounceV10.html?a=#{Base64.encode64(return_url)}" if APOLLO_INTERNAL_PRODUCTION
      url
    end
  end

  private

  def setup_url(envelope_id, url, role, name, email)
    create_recipient_view(
      envelope_id: envelope_id,
      return_url: url,
      role: role,
      name: name,
      email: email
    )
  end
end
