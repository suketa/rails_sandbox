require 'rails_helper'

RSpec.describe type: :system do
  # using :device_name metadata does not work fine.
  # describe 'when iPhone 8', device_name: 'iPhone 5' do
  #   before do
  #     visit home_index_path
  #   end
  #   it do
  #     expect(page).to have_content 'iPhone'
  #   end
  # end
  #
  describe 'index' do
    before do
      visit home_index_path
    end

    let(:user_agent_pattern) do
      device_name = ENV.fetch('DEVICE_NAME', nil)
      case device_name
      when /iphone/i
        'iPhone'
      else
        'HeadlessChrome'
      end
    end

    it 'show user agent' do
      expect(page).to have_content user_agent_pattern
    end
  end
end
