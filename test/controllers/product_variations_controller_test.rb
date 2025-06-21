require "test_helper"

class ProductVariationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get product_variations_index_url
    assert_response :success
  end

  test "should get show" do
    get product_variations_show_url
    assert_response :success
  end

  test "should get create" do
    get product_variations_create_url
    assert_response :success
  end

  test "should get update" do
    get product_variations_update_url
    assert_response :success
  end

  test "should get destroy" do
    get product_variations_destroy_url
    assert_response :success
  end
end
