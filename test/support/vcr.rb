require 'vcr'

VCR.configure do |config|
  config.ignore_hosts '127.0.0.1' # blog.narnach.com/blog/2021/system-tests-in-rails-6-plus-rspec-plus-vcr-plus-capybara/

  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock
end

# this example from vcr/vcr/blob/master/README.md
# class VCRTest < ActiveSupport::TestCase
#   def test_example_dot_com
#     VCR.use_cassette("synopsis") do
#       response = Net::HTTP.get_response(URI('http://www.iana.org/domains/reserved'))
#       assert_match /Example domains/, response.body
#     end
#   end
# end
