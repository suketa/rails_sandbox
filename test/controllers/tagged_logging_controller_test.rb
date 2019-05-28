require 'test_helper'

class TaggedLoggingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tagged_logging_index_url
    assert_response :success
  end

end
