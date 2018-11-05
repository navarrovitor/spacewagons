require 'test_helper'

class PartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parts_index_url
    assert_response :success
  end

  test "should get show" do
    get parts_show_url
    assert_response :success
  end

  test "should get new" do
    get parts_new_url
    assert_response :success
  end

  test "should get create" do
    get parts_create_url
    assert_response :success
  end

  test "should get edit" do
    get parts_edit_url
    assert_response :success
  end

  test "should get update" do
    get parts_update_url
    assert_response :success
  end

  test "should get transaction" do
    get parts_transaction_url
    assert_response :success
  end

  test "should get destroy" do
    get parts_destroy_url
    assert_response :success
  end

end
