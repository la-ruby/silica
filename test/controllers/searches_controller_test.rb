require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @project = create(:project)
  end

  test "post submission for listings component" do
    post "/searches", params: {"q"=>"q", "beds"=>"5", "baths"=>"4", "sort"=>"any", "page"=>"1", "map"=>"0"}, headers: { accept: Mime[:turbo_stream].to_s }
    assert_equal "200", response.code
  end
end
