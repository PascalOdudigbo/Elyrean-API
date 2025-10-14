require "test_helper"

class ReturnedItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get returned_items_index_url
    assert_response :success
  end

  test "should get show" do
    get returned_items_show_url
    assert_response :success
  end

  test "should get create" do
    get returned_items_create_url
    assert_response :success
  end

  test "should get update" do
    get returned_items_update_url
    assert_response :success
  end

  test "should get destroy" do
    get returned_items_destroy_url
    assert_response :success
  end
end
