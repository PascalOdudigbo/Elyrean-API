require "test_helper"

class DiscountProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get discount_products_show_url
    assert_response :success
  end

  test "should get create" do
    get discount_products_create_url
    assert_response :success
  end

  test "should get destroy" do
    get discount_products_destroy_url
    assert_response :success
  end
end
