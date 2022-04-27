# Some hacks to ensure not error when webdrivers, webmock, vcr in use
# see
# https://github.com/titusfortner/webdrivers/wiki/Using-with-VCR-or-WebMock

#
#
#
#
# For VCR
require 'uri'

# With activesupport gem
driver_hosts = Webdrivers::Common.subclasses.map { |driver| URI(driver.base_url).host }


# Without activesupport gem
driver_hosts = (ObjectSpace.each_object(Webdrivers::Common.singleton_class).to_a - [Webdrivers::Common]).map { |driver| URI(driver.base_url).host }

VCR.configure { |config| config.ignore_hosts(*driver_hosts) }

#
#
#
#
#
# For Webmock
driver_urls = Webdrivers::Common.subclasses.map(&:base_url)

# Without activesupport gem
driver_urls = (ObjectSpace.each_object(Webdrivers::Common.singleton_class).to_a - [Webdrivers::Common]).map(&:base_url)

driver_urls << /geckodriver/

# We've seen [a redirect](https://github.com/titusfortner/webdrivers/issues/204) to this domain
driver_urls += ["github-releases.githubusercontent.com"] # this is added

WebMock.disable_net_connect!(allow_localhost: true, allow: driver_urls)
