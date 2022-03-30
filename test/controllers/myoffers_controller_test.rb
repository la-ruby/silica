require "test_helper"

class MyOffersControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in create(:user)
  end

  test 'get /offer/:mop_token' do
    project = create(:project)
    get "/offer/#{project.repc.mop_token}"
    assert_equal "200", response.code
  end

  test 'get /offer/:mop_token as second seller' do
    project = create(:project)
    get "/offer/#{project.repc.second_seller_mop_token}"
    assert_equal "200", response.code
  end

  test 'get /offer/:mop_tokenparam signing_complete' do
    project = create(:project)
    get "/offer/#{project.repc.mop_token}?event=signing_complete"
    assert_equal "200", response.code
  end

  test 'get /offer/:mop_token as second seller with param signing_complete' do
    project = create(:project)
    get "/offer/#{project.repc.second_seller_mop_token}?event=signing_complete"
    assert_equal "200", response.code
  end

  test 'get /offer/:mop_token as second seller with a 1st seller acceptance' do
    project = create(:project)
    project.repc.update(accepted_at: Time.now.iso8601)
    get "/offer/#{project.repc.second_seller_mop_token}"
    assert_equal "200", response.code
  end

  test 'get /offer/:mop_token as second seller with a both seller acceptance' do
    project = create(:project)
    project.repc.update(accepted_at: Time.now.iso8601, second_seller_accepted_at: Time.now.iso8601)
    get "/offer/#{project.repc.second_seller_mop_token}"
    assert_equal "200", response.code
  end

  test 'get /offer/:mop_token as second seller with a both seller rejection' do
    project = create(:project)
    project.repc.update(rejected_at: Time.now.iso8601, second_seller_rejected_at: Time.now.iso8601)
    get "/offer/#{project.repc.second_seller_mop_token}"
    assert_equal "200", response.code
  end

  test 'get /offer/:token and addendum card shows up' do
    project = create(:project, :has_av)
    AddendumVersion.last.update(signed_by_company_at: Time.now.iso8601)
    AddendumVersion.last.update(sent_to_seller_at: Time.now.iso8601)
    get "/offer/#{project.repc.mop_token}"
    assert_equal "200", response.code
  end

  test 'get /offer/:token and addendum card shows up second_seller_mode' do
    project = create(:project, :has_av)
    project.dual_for_testing!
    AddendumVersion.last.update(signed_by_company_at: Time.now.iso8601)
    AddendumVersion.last.update(sent_to_seller_at: Time.now.iso8601)
    get "/offer/#{project.repc.second_seller_mop_token}"
    assert_equal "200", response.code
  end

  test 'get /offer/:token and addendum second seller mode, one accept, card shows up' do
    project = create(:project, :has_av)
    project.dual_for_testing!
    AddendumVersion.last.update(signed_by_company_at: Time.now.iso8601)
    AddendumVersion.last.update(sent_to_seller_at: Time.now.iso8601)
    AddendumVersion.last.update(accepted_at: Time.now.iso8601)
    get "/offer/#{project.repc.second_seller_mop_token}"
    assert_equal "200", response.code
  end

  test 'get /offer/:token and addendum second seller mode, one reject, card shows up' do
    project = create(:project, :has_av)
    project.dual_for_testing!
    AddendumVersion.last.update(signed_by_company_at: Time.now.iso8601)
    AddendumVersion.last.update(sent_to_seller_at: Time.now.iso8601)
    AddendumVersion.last.update(rejected_at: Time.now.iso8601)
    get "/offer/#{project.repc.second_seller_mop_token}"
    assert_equal "200", response.code
  end
end
