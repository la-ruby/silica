# frozen_string_literal: true

class KodaksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_kodak, only: %i[update]
  before_action :set_area_backend
  after_action :verify_authorized
  protect_from_forgery except: :create

  def create
    authorize nil, policy_class: KodakPolicy

    project = Project.find(params[:project])
    kodak = project.kodaks.create
    kodak.pic.attach params[:file]
    Turbo::StreamsChannel.broadcast_update_to(
      'kodaks',
      target: 'kodaks',
      partial: '/projects/shared/kodaks',
      locals: { project: project.id, current_area: Area::Backend.new }
    )
  end

  def update
    authorize nil, policy_class: KodakPolicy

    @kodak.update(kodak_params)
    respond_to do |format|
      format.turbo_stream
      # format.html { redirect_to example_url(@example), notice: "Example was successfully updated." }
      # format.json { render :show, status: :ok, location: @example }
    end
  end

  def destroy
    authorize nil, policy_class: KodakPolicy

    project = Project.find(params[:project])
    project.kodaks.find(params[:kodak])&.destroy

    Turbo::StreamsChannel.broadcast_update_to(
      'kodaks',
      target: 'kodaks',
      partial: '/projects/shared/kodaks',
      locals: { project: project.id, current_area: Area::Backend.new }
    )
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_kodak
    @kodak = Kodak.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def kodak_params
    params.require(:kodak).permit(:primary, :marketplace)
  end
end
