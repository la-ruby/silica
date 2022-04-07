# frozen_string_literal: true

class ScoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend
  after_action :verify_authorized

  # POST /scouts or /scouts.json
  def create
    authorize nil, policy_class: ScoutPolicy
    project = Project.find(scout_params[:project_id])
    project.update(scout: Scout.generate(project))

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: "Created Scout Link" }),
          turbo_stream.replace('apollo-inspection-overview-pane', partial: '/scouts/inspection_overview_pane', locals: { project_id: scout_params[:project_id] })
        ]
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def scout_params
    params.require(:scout).permit(:project_id)
  end
end
