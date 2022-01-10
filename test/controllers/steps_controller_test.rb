require "test_helper"

class StepsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get steps_show_url
    assert_response :success
  end
end
