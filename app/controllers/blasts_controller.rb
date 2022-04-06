# frozen_string_literal: true

# Marketing "blasts" / send to mailing list
class BlastsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend
  after_action :verify_authorized

  # POST /examples or /examples.json
  def create
    authorize nil, policy_class: BlastPolicy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
                 turbo_stream.replace('flashes',
                                      partial: '/flashes',
                                      locals: {
                                        message:
                                          MarketingMail.new.perform(project_id: blast_params[:project]).to_s })
        ]
      end
    end


  end

  private

  # Only allow a list of trusted parameters through.
  def blast_params
    params.require(:blast).permit(:project)
  end
end
