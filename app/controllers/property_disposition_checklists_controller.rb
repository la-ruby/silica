# frozen_string_literal: true

class PropertyDispositionChecklistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property_disposition_checklist, only: %i[edit update]

  # PATCH/PUT /property_disposition_checklists/1 or /property_disposition_checklists/1.json
  def update
    authorize @property_disposition_checklist
    @property_disposition_checklist.update(property_disposition_checklist_params)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('flashes', partial: '/flashes', locals: { message: 'Saved' })
        ]
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_property_disposition_checklist
    @property_disposition_checklist = PropertyDispositionChecklist.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def property_disposition_checklist_params
    params.require(:property_disposition_checklist).permit(:property_address, :owner_contact_info, :summary_of_deal, :copy_of_repc, :acquire_property_insurance, :connect_with_preferred, :connect_with_preferred_textarea, :upload_proof_of_insurance, :submit_all_closing_docs, :settlement_statement, :loan_documents, :loan_documents, :financial_records, :receipts, :send_notice_of, :how_and_when, :who_tenants_can_contact, :date_updates_sent, :date_updates_sent_dateinput, :send_out_new, :send_out_new_dateinput, :send_out_a_notice_to_vacate, :send_out_a_notice_to_vacate_dateinput, :coordinate_to_have, :coordinate_with_property, :connect_with_agent, :connect_with_agent_dateinput, :important_notes_for, :important_notes_for_textarea, :once_property_is_sold, :stop_utility, :date_utilities_stopped, :date_utilities_stopped_dateinput,
                                                           :all_insurance_canceled, :all_insurance_canceled_dateinput)
  end
end
