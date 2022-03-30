# frozen_string_literal: true

# Handles save of pane
class DispositionsPrepareListingPanesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resources
  after_action :verify_authorized

  # POST /examples or /examples.json
  def create
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: resource_updates }),
          turbo_stream.replace('dispositions_prepare_listing_pane', partial: '/dispositions_prepare_listing_pane/dispositions_prepare_listing_pane', locals: { project: @project.id })
        ]
      end
    end
  end

  private

  def set_resources
    @project = Project.find params[:project_id]
    authorize nil, policy_class: DispositionsPrepareListingPanePolicy
  end

  def resource_updates
    listing = @project.listing
    listing.update(dispositions_prepare_listing_pane_params)
    listing.errors.full_messages.join(', ').presence || 'Updated'
  end

  # Only allow a list of trusted parameters through.
  def dispositions_prepare_listing_pane_params
    params.require(:dispositions_prepare_listing_pane).permit(
      :title,
      :description,
      :legacy_description,
      :walkthrough_date,
      :walkthrough_time,
      :walkthrough_schedule_email,
      :walkthrough_schedule_email_send_now,
      :marketing_email,
      :marketing_email_send_now,
      :beds,
      :property_type,
      :opportunity_type,
      :price_sqft,
      :baths,
      :hoa_fees,
      :heating,
      :sqft,
      :owner_occupied,
      :cooling,
      :year,
      :lot_size,
      :down_payment,
      :monthly_payment,
      :term_length,
      :estimated_remaining_mortgage,
      :interest_rate,
      :balloon_payment,
      :suggested_price,
      :listed
    )
  end
end
