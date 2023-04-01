require "test_helper"

class HabitsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get habits_show_url
    assert_response :success
  end
end
