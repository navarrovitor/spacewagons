require 'test_helper'

class ShipsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get ships_show_url
    assert_response :success
  end

  test "should get edit" do
    get ships_edit_url
    assert_response :success
  end

  test "should get update" do
    get ships_update_url
    assert_response :success
  end

end
