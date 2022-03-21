require "test_helper"

class PropertyDispositionChecklistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test 'PATCH /property_disposition_checklists/:n' do
    patch "/property_disposition_checklists/#{@project.property_disposition_checklist.id}", params: {"authenticity_token"=>"[FILTERED]", "property_disposition_checklist"=>{"property_address"=>"false", "owner_contact_info"=>"false", "summary_of_deal"=>"false", "copy_of_repc"=>"false", "acquire_property_insurance"=>"false", "connect_with_preferred"=>"false", "connect_with_preferred_textarea"=>"", "upload_proof_of_insurance"=>"false", "submit_all_closing_docs"=>"false", "settlement_statement"=>"false", "loan_documents"=>"false", "financial_records"=>"false", "receipts"=>"false", "send_notice_of"=>"false", "how_and_when"=>"false", "who_tenants_can_contact"=>"false", "date_updates_sent"=>"false", "date_updates_sent_dateinput"=>"", "send_out_new"=>"false", "send_out_new_dateinput"=>"", "send_out_a_notice_to_vacate"=>"false", "send_out_a_notice_to_vacate_dateinput"=>"", "coordinate_to_have"=>"false", "coordinate_with_property"=>"false", "connect_with_agent"=>"false", "connect_with_agent_dateinput"=>"", "important_notes_for"=>"true", "important_notes_for_textarea"=>"tesitng2", "once_property_is_sold"=>"false", "stop_utility"=>"false", "date_utilities_stopped"=>"false", "date_utilities_stopped_dateinput"=>"", "all_insurance_canceled"=>"false", "all_insurance_canceled_dateinput"=>""}} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
