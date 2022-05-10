# frozen_string_literal: true

class ProjectFilesController < ApplicationController
  before_action :set_project_file, only: %i[ show ]
  before_action :authenticate_user!
  before_action :set_area_backend
  after_action :verify_authorized
  protect_from_forgery except: :create

  def new
    @project = Project.find params[:project_id]
    authorize @project, policy_class: ProjectFilePolicy
    render layout: nil
  end

  def show
    authorize @project_file
    redirect_to rails_blob_path(@project_file.silicafile, disposition: "attachment")
  end

  def create
    @project = Project.find params[:project_id]
    authorize @project, policy_class: ProjectFilePolicy
    pf = @project
      .project_files
      .create(folder: params[:folder].presence || 'root')
    pf.silicafile.attach(params[:file])
    Event.create(
      category: 'file_added',
      timestamp: Time.now,
      record_id: @project.id,
      record_type: 'Project',
      secondary_record_id: pf.id,
      secondary_record_type: 'ProjectFile',
      inventor_id: current_user.id
    )
    flash[:notice] = 'Uploaded'
    redirect_to "/projects/#{@project.id}?tab=files&folder=#{params[:folder]}"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project_file
    @project_file = ProjectFile.find params[:id]
  end

end
