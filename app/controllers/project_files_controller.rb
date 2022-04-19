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
    @project.project_files.create.silicafile.attach(params[:file])
    flash[:notice] = 'Uploaded'
    redirect_to "/projects/#{@project.id}?tab=files"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project_file
    @project_file = ProjectFile.find params[:id]
  end

end
