# frozen_string_literal: true

# Addendum Verdicts Controller
class AddendumVerdictsController < ApplicationController
  include DocuSign::Mixin
  before_action :set_area_offer
  after_action :verify_authorized

  # POST /examples or /examples.json
  def create
    authorize nil, policy_class: AddendumVerdictPolicy
    @addendum_version = AddendumVersion.find params[:addendum_version_id]
    @repc = Repc.find(@addendum_version.related_repc_id)
    @second_seller_mode = (params[:second_seller_mode] == 'true')
    @url = addendum_url(params[:action_button])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('apollo-redirect', partial: '/redirect', locals: { url: @url })]
      end
    end
  end

  private

  def addendum_url(action_button)
    case action_button
    when 'reject'
      process_rejection
    when 'sign_via_docusign'
      process_acceptance
    else
      ''
    end
  end

  def process_rejection
    if @second_seller_mode
      @addendum_version.update(second_seller_rejected_at: Time.now.iso8601)
      @addendum_version.set_status_to_accepted_maybe
      # No email for addendums
      @url = "#{APOLLO_PORTAL_FULL_DOMAIN}/offer-addendum/#{@addendum_version.second_seller_mop_token}/feedback/new"
    else
      @addendum_version.update(rejected_at: Time.now.iso8601)
      @addendum_version.set_status_to_accepted_maybe
      # no email
      @url = "#{APOLLO_PORTAL_FULL_DOMAIN}/offer-addendum/#{@addendum_version.mop_token}/feedback/new"
    end
  end

  def process_acceptance
    @url = if @second_seller_mode
             set_url(@addendum_version.docusign_envelope_id,
                     "#{APOLLO_PORTAL_FULL_DOMAIN}/offer/#{@repc.second_seller_mop_token}", :second_seller,
                     @repc.project.secondName, @repc.project.secondEmail)
           else
             set_url(@addendum_version.docusign_envelope_id, "#{APOLLO_PORTAL_FULL_DOMAIN}/offer/#{@repc.mop_token}",
                     :seller, @repc.project.name, @repc.project.email)
           end
    enc = "#{APOLLO_PORTAL_FULL_DOMAIN}/offer/#{@second_seller_mode ? @repc.second_seller_mop_token : @repc.mop_token}"
    @url = "#{APOLLO_CDN}/bounceV10.html?a=#{enc}" if APOLLO_INTERNAL_PRODUCTION
  end

  def set_url(envelope_id, return_url, role, name, email)
    create_recipient_view(
      envelope_id: envelope_id,
      return_url: return_url,
      role: role,
      name: name,
      email: email
    )
  end
end
