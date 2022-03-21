require "test_helper"

class AddendumVersionTest < ActiveSupport::TestCase
  setup do
    create(:project, :has_second_seller, :has_av)
  end

  # when acceptance present
  test '#set_status_to_accepted_maybe' do
    AddendumVersion.last.accept_for_testing!

    AddendumVersion.last.set_status_to_accepted_maybe
    assert_equal 'Accepted', AddendumVersion.last.status
  end

  # when rejection present
  test '#set_status_to_accepted_maybe /2' do
    AddendumVersion.last.reject_for_testing!

    AddendumVersion.last.set_status_to_accepted_maybe
    assert_equal 'Rejected', AddendumVersion.last.status
  end
end
