require "test_helper"

class ProductReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get product_reviews_index_url
    assert_response :success
  end

  test "should get show" do
    get product_reviews_show_url
    assert_response :success
  end

  test "should get create" do
    get product_reviews_create_url
    assert_response :success
  end

  test "should get update" do
    get product_reviews_update_url
    assert_response :success
  end

  test "should get destroy" do
    get product_reviews_destroy_url
    assert_response :success
  end
end
