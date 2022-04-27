require "application_system_test_case"

# Eventually this test can go away
# test was helpful in the early stages of setting up actioncable
class FirstStreamTest < ApplicationSystemTestCase
  setup do
    login_flow
  end

  test "project creation notification" do
    new_window = open_new_window
    within_window new_window do
      visit "/projects"
    end

    create_project_flow
    switch_to_window new_window
    assert_selector ".toast", visible: nil
    assert first(".toast", visible: nil)['innerHTML'] =~ /Project (\d+) created/
  end
end
