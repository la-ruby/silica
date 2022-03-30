# frozen_string_literal: true

# Handles save of pane
class UnderwritingIntakeFormPanesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resources
  before_action :set_area_backend
  after_action :verify_authorized

  # POST /examples or /examples.json
  def create
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: resource_updates }),
          turbo_stream.replace('underwriting-intake-form-pane', partial: '/underwriting_intake_form_panes/underwriting_intake_form_pane', locals: { project_id: @project.id })
        ]
      end
    end
  end

  private

  def set_resources
    @project = Project.find params[:project_id]
    authorize nil, policy_class: UnderwritingIntakeFormPanePolicy
  end

  def resource_updates
    intake_form = @project.intake_form
    intake_form.update(underwriting_intake_form_pane_params)
    intake_form.errors.full_messages.join(', ').presence || 'Updated'
  end

  # Only allow a list of trusted parameters through.
  def underwriting_intake_form_pane_params
    params.require(:underwriting_intake_form_pane).permit(
      :what_type_of_property_is_this, :who_is_the_purchaser, :property_analysis, :internal_summary_for_dispositions, :disposition_plan, :does_the_property_have_current_tenants, :are_those_tenants_staying, :do_rent_rates_need_to_be_adjusted, :if_so_what_is_the_new_rate, :does_the_property_need_water_power, :who_will_pay_for_water_power, :does_the_property_need_to_be_cleaned, :is_the_property_in_an_hoa, :if_there_is_an_hoa_who_is_the_contact, :is_this_property_being_listed_as_is, :what_repairs_need_to_be_managed_by_company, :what_is_the_budget_for_required_repairs, :other_notes, :completed
    )
  end
end
