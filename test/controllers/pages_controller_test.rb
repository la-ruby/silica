require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'rendering root asGuest hostBackend' do
    host! APOLLO_BACKEND_DOM
    get "/"
    assert_redirected_to "http://#{APOLLO_BACKEND_DOM}/projects"
  end

  test 'rendering root asUser hostBackend' do
    sign_in create(:user)
    host! APOLLO_BACKEND_DOM
    get "/"
    assert_redirected_to "http://#{APOLLO_BACKEND_DOM}/projects"
  end

  test 'rendering root asGuest hostMbo' do
    host! "test.#{APOLLO_MBO_DOM}"
    get "/"
    assert_redirected_to "http://test.#{APOLLO_MBO_DOM}/empty.html"
  end

  test 'rendering root asUser hostMbo' do
    host! "#{APOLLO_MBO_DOM}"
    sign_in create(:user)

    get "/"
    assert_redirected_to "http://#{APOLLO_MBO_DOM}/empty.html"
  end

  test 'rendering root asGuest hostMarketplace' do
    host! "#{APOLLO_MARKETPLACE_DOM}"
    get "/"
    assert_redirected_to "http://#{APOLLO_MARKETPLACE_DOM}/listings"
  end

  test 'rendering root asUser hostMarketplace' do
    host! "#{APOLLO_MARKETPLACE_DOM}"
    sign_in create(:user)

    get "/"
    assert_redirected_to "http://#{APOLLO_MARKETPLACE_DOM}/listings"
  end
end
