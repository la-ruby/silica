# frozen_string_literal: true

# Handles save of pane
class IntakeFormCompletionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resources
  before_action :set_area_backend
  before_action :authorize_intake_form_completion_policy
  after_action :verify_authorized

  # POST /examples or /examples.json
  def create
    mark_as_complete
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream_array(turbo_stream)
      end
    end
  end

  # DELETE /examples/1 or /examples/1.json
  def destroy
    undo_mark_as_complete
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream_array(turbo_stream)
      end
    end
  end

  private

  def authorize_intake_form_completion_policy
    authorize nil, policy_class: IntakeFormCompletionPolicy
  end

  def turbo_stream_array(turbo_stream)
    [
      turbo_stream.replace('flashes', partial: '/flashes', locals: { message: 'Updated' }),
      turbo_stream.replace('underwriting-intake-form-pane',
                           partial: '/underwriting_intake_form_panes/underwriting_intake_form_pane',
                           locals: { project_id: @project.id })
    ]
  end

  def set_resources
    @project = Project.find params[:project_id]
    @intake_form = @project.intake_form
  end

  def mark_as_complete
    @intake_form.update_attribute(:completed, 'true')
    @intake_form.update_attribute(:property_analysis, 'Complete')
    @intake_form.update_attribute(:disposition_plan, 'Complete')
  end

  def undo_mark_as_complete
    @intake_form.update_attribute(:completed, 'false')
    @intake_form.update_attribute(:property_analysis, 'incomplete')
    @intake_form.update_attribute(:disposition_plan, 'incomplete')
  end
end
