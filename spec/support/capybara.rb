require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do |example|
    driven_by :selenium, using: :headless_chrome, screen_size: [1024, 768], options: {
      browser: :remote,
      url: ENV.fetch('SELENIUM_DRIVER_URL'),
      desired_capabilities: :chrome
    } do |driver_option|
      # driver_option.add_emulation(device_name: example.metadata[:device_name])
      driver_option.add_emulation(device_name: ENV.fetch('DEVICE_NAME', nil))
      driver_option.add_argument('no-sandbox')
    end
    Capybara.server_host = 'web'
    Capybara.app_host = 'http://web'
  end
end
