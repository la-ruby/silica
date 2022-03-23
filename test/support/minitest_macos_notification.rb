require "minitest/reporters"

# https://github.com/technicalpanda/minitest-macos-notification#usage
require "minitest/autorun"
require "minitest/macos_notification"
require "minitest/reporters"

Minitest::Reporters.use!(
  [
    Minitest::Reporters::DefaultReporter.new,
    # Minitest::Reporters::MacosNotificationReporter.new(
    #   title: "minitest_macos_notification.rb")
  ],
  ENV,
  Minitest.backtrace_filter
)
