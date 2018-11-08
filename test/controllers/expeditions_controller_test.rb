require 'test_helper'

class ExpeditionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get expeditions_new_url
    assert_response :success
  end

  test "should get create" do
    get expeditions_create_url
    assert_response :success
  end

end
