require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'cucumber'
require 'rspec'
require 'uri'
require 'net/http'
require 'rest_client'
require 'json-schema'

Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium
Capybara.default_selector = :css
Capybara.default_max_wait_time = 7
Capybara.default_normalize_ws = true

rendered_config = ERB.new(File.read('config/config.json')).result binding
$config = JSON.parse(rendered_config)

Capybara.register_driver :selenium do |app|
    prefs = {
        download: {
            prompt_for_download: false,
            default_directory: $path
        }
    }
    options = Selenium::WebDriver::Chrome::Options.new(prefs: prefs)

    if Selenium::WebDriver::Platform.windows?
      Selenium::WebDriver::Chrome.driver_path = File.join(Dir.pwd, 'resources', 'chromedriver.exe').tr('/', '\\')
    end
    options.add_argument('--start-maximized')

    # Capybara::Selenium::Driver.new(app, :browser => :chrome, :options => options, http_client: client)
    $driver = Capybara::Selenium::Driver.new(app, detach: false, browser: :chrome, options: options)
end

