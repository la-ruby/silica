# frozen_string_literal: true

class ProjectFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend
  after_action :verify_authorized

  def show
    authorize nil, policy_class: ProjectFilePolicy
    render plain: 'File will download shortly...'
  end

  private
end
