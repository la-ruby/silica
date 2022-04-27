module SystemTestStepDefinitions
  def login_flow
    create(:user) if User.count.zero?

    visit projects_url
    fill_in 'name@example.com', with: 'example@example.com'
    fill_in 'Password', with: 'testing'
    click_button 'sign in'
  end

  def create_project_flow
    find("#silica-new-project-button").click
    fill_in 'project_name', with: 'John Doe'
    fill_in 'project_phone', with: '1231231234'
    fill_in 'project_email', with: 'testing@example.com'
    choose 'Asap'

    # simulate google places autocomplete
    page.execute_script("
      $('#id1641254485 #project_state').val('testing');
      $('#id1641254485 #project_city').val('testing');
      $('#id1641254485 #project_zip').val('testing');
      $('#id1641254485 #project_street').val('testing');
      $('#segmented-address').removeClass('d-none');
      $('#a1631804549').addClass('d-none');
    ")
    find("#new_offer_submit_1").click
  end
end
