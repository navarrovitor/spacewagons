require 'test_helper'

class RacesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get races_create_url
    assert_response :success
  end

  test "should get show" do
    get races_show_url
    assert_response :success
  end

end
