# frozen_string_literal: true

# Allows charing project status from /projects/n/underwriting_review_offer pages
class StatusesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_area_backend
  after_action :verify_authorized

  def update
    authorize nil, policy_class: StatusPolicy
    project = Project.find params[:project_id]
    case params[:button]
    when 'statusCompletedWon'
      project.update(status: 'Completed Won')
    when 'statusCompletedClosedLost'
      project.update(status: 'Completed Closed/Lost')
    when 'statusOpen'
      project.update(status: 'Open')
    end    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('apollo-reload', partial: '/reload', locals: { example: '1' })
        ]
      end
    end
  end
end
