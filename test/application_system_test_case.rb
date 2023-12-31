require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase

  Capybara.register_driver :remote_selenium do |app|
    # Pass our arguments to run headless
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--window-size=1400,1400")

    # and point capybara at our chromium docker container
    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: "http://chrome-server:4444/wd/hub",
      options: options,
    )
  end

  # set the capybara driver configs
  Capybara.javascript_driver = :remote_selenium
  Capybara.default_driver = :remote_selenium

  # This will force capybara to inclue the port in requests
  Capybara.always_include_port = true

  driven_by :remote_selenium
end
