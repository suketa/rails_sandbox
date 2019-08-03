require 'rails_helper'

RSpec.describe type: :system do
  before do
    visit home_index_path
  end
  describe 'when iPhone 8', device_name: 'iPhone 5' do
    it do
      expect(page).to have_content 'hoge'
    end
  end
  describe 'when using browser' do
    it '' do
      expect(page).to have_content 'ooo'
    end
  end
end
