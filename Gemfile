source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

# Use local checkout of Rails
gem 'rails', :github => 'rails/rails', :branch => '7-0-stable'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
# gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', :github => 'hotwired/turbo-rails', :branch => 'main'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Use Sass to process CSS
gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "devise", "~> 4.8", :git => "https://github.com/heartcombo/devise", :branch => "main"
gem "pundit", "~> 2.2", :git => "https://github.com/varvet/pundit", :branch => "main"
gem "aws-sdk-s3"
gem "nice_partials", "~> 0.1.6", :git => "https://github.com/bullet-train-co/nice_partials", :branch => "main"
gem "kaminari", "~> 1.2", :git => "https://github.com/kaminari/kaminari", :branch => "master"
gem "factory_bot_rails", "~> 6.2", :groups => [:test, :development], :git => "https://github.com/thoughtbot/factory_bot_rails", :branch => "main"
gem "faker", "~> 2.19", :git => "https://github.com/faker-ruby/faker", :branch => "master"
gem 'simplecov', require: false, group: :test
gem "minitest-test_profile", "~> 0.2.2", :group => :test, :git => "https://github.com/y-yagi/minitest-test_profile", :branch => "master"
gem "webmock", "~> 3.14", :group => :test, :git => "https://github.com/bblimke/webmock", :branch => "master"
gem "vcr", "~> 6.0", :group => :test, :git => "https://github.com/vcr/vcr", :branch => "master"

gem "clockwork", "~> 3.0", :git => "https://github.com/Rykian/clockwork", :branch => "master"
gem "sendgrid-ruby", ">= 6.6"
gem "rollbar", ">= 3.3"

# stuff quite specific to business domain
gem "add_to_calendar"
gem 'docusign_esign'

gem "redis"
gem "rails-settings-cached", :git => "https://github.com/huacnlee/rails-settings-cached", :branch => "main"
gem "minitest-autotest"
gem "minitest-macos-notification"
gem 'minitest-stub-const'

gem "ransack", "~> 2.6", :github => "activerecord-hackery/ransack"
gem 'apparition', github: 'twalpole/apparition'
gem 'rexml', github: 'ruby/rexml'


