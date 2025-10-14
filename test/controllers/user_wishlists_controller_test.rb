require "test_helper"

class UserWishlistsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_wishlists_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_wishlists_destroy_url
    assert_response :success
  end
end
