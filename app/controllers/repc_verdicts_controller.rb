class RepcVerdictsController < ApplicationController
  include DocuSign::Mixin
  after_action :verify_authorized

  # POST /examples or /examples.json
  def create
    authorize nil, policy_class: RepcVerdictPolicy

    @repc = Repc.find params[:repc_id]
    @second_seller_mode = (params[:second_seller_mode] == 'true')
    @url = ''
    process_rejection if params[:action_button] == 'reject'
    process_acceptance if params[:action_button] == 'sign_via_docusign'
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('apollo-redirect', partial: '/redirect', locals: { url: @url })
        ]
      end
    end
  end

  private

  def process_rejection
    if @second_seller_mode
      @repc.update(second_seller_rejected_at: Time.now.iso8601)
      OfferRejectedMail.new.perform(to: @repc.project.secondEmail)
      @url = "#{APOLLO_PORTAL_FULL_DOMAIN}/offer/#{@repc.second_seller_mop_token}/feedback/new"
    else
      @repc.update(rejected_at: Time.now.iso8601)
      OfferRejectedMail.new.perform(to: @repc.project.email)
      @url = "#{APOLLO_PORTAL_FULL_DOMAIN}/offer/#{@repc.mop_token}/feedback/new"
    end
  end

  def process_acceptance
    if @second_seller_mode
      @url = create_recipient_view(
        envelope_id: @repc.docusign_envelope_id,
        return_url: "#{APOLLO_PORTAL_FULL_DOMAIN}/offer/#{@repc.second_seller_mop_token}",
        role: :second_seller,
        name: @repc.project.secondName,
        email: @repc.project.secondEmail
      )
      encoded = "#{APOLLO_PORTAL_FULL_DOMAIN}/offer/#{@repc.second_seller_mop_token}"
      @url = "#{APOLLO_CDN}/bounceV10.html?a=#{encoded}" if APOLLO_INTERNAL_PRODUCTION
    else
      @url = create_recipient_view(
        envelope_id: @repc.docusign_envelope_id,
        return_url: "#{APOLLO_PORTAL_FULL_DOMAIN}/offer/#{@repc.mop_token}",
        role: :seller,
        name: @repc.project.name,
        email: @repc.project.email
      )
      encoded = "#{APOLLO_PORTAL_FULL_DOMAIN}/offer/#{@repc.mop_token}"
      @url = "https://#{APOLLO_CDN}/bounceV10.html?a=#{encoded}" if APOLLO_INTERNAL_PRODUCTION
    end
  end
end
