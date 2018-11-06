require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get test_dashboard_url
    assert_response :success
  end

  test "should get boardin" do
    get test_boardin_url
    assert_response :success
  end

end
