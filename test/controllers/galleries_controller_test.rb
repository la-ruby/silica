#frozen string literal true

require "test_helper"

class GalleriesControllerTest < ActionDispatch::IntegrationTest
  test "post /gallery" do
    post "/gallery", params: {}, headers: { accept: Mime[:turbo_stream].to_s, "HTTP_REFERER": "/testing" }
    assert_equal "302", response.code
  end
end
