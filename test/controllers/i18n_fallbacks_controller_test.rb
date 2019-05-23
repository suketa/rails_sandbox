require 'test_helper'

class I18nFallbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get i18n_fallbacks_index_url
    assert_response :success
  end

end
