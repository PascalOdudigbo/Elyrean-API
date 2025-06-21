require "test_helper"

class DiscountsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get discounts_index_url
    assert_response :success
  end

  test "should get show" do
    get discounts_show_url
    assert_response :success
  end

  test "should get create" do
    get discounts_create_url
    assert_response :success
  end

  test "should get update" do
    get discounts_update_url
    assert_response :success
  end

  test "should get destroy" do
    get discounts_destroy_url
    assert_response :success
  end
end
