require "test_helper"

class DispositionsPrepareListingPanesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = create(:project)
    sign_in create(:user)
  end

  test 'POST /dispositions_prepare_listing_panes' do
    post "/dispositions_prepare_listing_panes", params: {"authenticity_token"=>"[FILTERED]", "project_id"=>@project.id, "dispositions_prepare_listing_pane"=>{"suggested_price"=>"", "title"=>"Testing9", "legacy_description"=>"testing", "walkthrough_date"=>"", "walkthrough_time"=>"", "walkthrough_schedule_email_send_now"=>"false", "beds"=>"2", "property_type"=>"Testing", "price_sqft"=>"1000", "baths"=>"2", "hoa_fees"=>"Testing", "heating"=>"Testing", "sqft"=>"1", "owner_occupied"=>"true", "cooling"=>"Testing", "year"=>"1990", "lot_size"=>"1", "down_payment"=>"33", "monthly_payment"=>"", "term_length"=>"", "estimated_remaining_mortgage"=>"", "interest_rate"=>"", "balloon_payment"=>"", "listed"=>"true"}} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

  test 'POST /dispositions_prepare_listing_panes isNC' do
    @project.update(state: 'North Carolina')

    post "/dispositions_prepare_listing_panes", params: {"authenticity_token"=>"[FILTERED]", "project_id"=>@project.id, "dispositions_prepare_listing_pane"=>{"suggested_price"=>"", "title"=>"Testing9", "description"=>"testing", "walkthrough_date"=>"", "walkthrough_time"=>"", "walkthrough_schedule_email_send_now"=>"false", "beds"=>"2", "property_type"=>"Testing", "price_sqft"=>"1000", "baths"=>"2", "hoa_fees"=>"Testing", "heating"=>"Testing", "sqft"=>"1", "owner_occupied"=>"true", "cooling"=>"Testing", "year"=>"1990", "lot_size"=>"1", "down_payment"=>"33", "monthly_payment"=>"", "term_length"=>"", "estimated_remaining_mortgage"=>"", "interest_rate"=>"", "balloon_payment"=>"", "listed"=>"true"}} , headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end

end
