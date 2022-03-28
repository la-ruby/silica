# originally from https://medium.com/@inanbunyamin90/using-capybara-for-scraping-9b078773c7c2

# require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'
require 'capybara/apparition'

# Capybara.javascript_driver = :chrome
Capybara.javascript_driver = :apparition
Capybara.current_driver = :apparition

browser = Capybara.current_session
driver = browser.driver.browser

browser.visit "https://example.com"
browser.save_screenshot
