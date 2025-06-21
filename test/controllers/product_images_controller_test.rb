require "test_helper"

class ProductImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get product_images_index_url
    assert_response :success
  end

  test "should get show" do
    get product_images_show_url
    assert_response :success
  end

  test "should get create" do
    get product_images_create_url
    assert_response :success
  end

  test "should get update" do
    get product_images_update_url
    assert_response :success
  end

  test "should get destroy" do
    get product_images_destroy_url
    assert_response :success
  end
end
