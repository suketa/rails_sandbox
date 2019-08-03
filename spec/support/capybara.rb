require 'capybara/rspec'

RSpec.configure do |config|
  driven_by_args = [
    :selenium,
    using: :headless_chrome,
    screen_size: [1400, 800]
  ]
  config.before(:each, type: :system) do |example|
    driver = driven_by(*driven_by_args) do |driver_option|
      example.metadata[:device_name] && driver_option.add_emulation(device_name: example.metadata[:device_name])
      driver_option.add_argument('no-sandbox')
      driver_option.add_argument('disable-dev-shm-usage')
      driver_option.add_preference(:detach, true)
    end
    driver.use
  end
end
