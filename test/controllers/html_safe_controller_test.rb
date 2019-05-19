require 'test_helper'

class HtmlSafeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get html_safe_index_url
    assert_response :success
  end

end
