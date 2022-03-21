require "test_helper"

class UnderwritingIntakeFormPanesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test 'POST /underwriting_intake_form_panes' do
    post "/underwriting_intake_form_panes", params: {"authenticity_token"=>"[FILTERED]", "project_id"=>@project.id, "underwriting_intake_form_pane"=>{"what_type_of_property_is_this"=>"", "who_is_the_purchaser"=>"", "property_analysis"=>"Complete", "internal_summary_for_dispositions"=>"", "disposition_plan"=>"Complete", "does_the_property_have_current_tenants"=>"", "do_rent_rates_need_to_be_adjusted"=>"", "are_those_tenants_staying"=>"", "if_so_what_is_the_new_rate"=>"", "does_the_property_need_water_power"=>"", "who_will_pay_for_water_power"=>"", "does_the_property_need_to_be_cleaned"=>"", "is_the_property_in_an_hoa"=>"", "if_there_is_an_hoa_who_is_the_contact"=>"", "is_this_property_being_listed_as_is"=>"", "what_is_the_budget_for_required_repairs"=>"", "what_repairs_need_to_be_managed_by_company"=>"", "other_notes"=>"testing1", "completed"=>"false"}} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
