# frozen_string_literal: true

# Marketing "blasts" / send to mailing list
class BlastsController < ApplicationController
  before_action :authenticate_user!

  # POST /examples or /examples.json
  def create
    authorize nil, policy_class: BlastPolicy
    @message = MarketingMail.new.perform(project_id: blast_params[:project]).to_s

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def blast_params
    params.require(:blast).permit(:project)
  end
end
