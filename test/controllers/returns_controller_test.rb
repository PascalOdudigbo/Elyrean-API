require "test_helper"

class ReturnsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get returns_index_url
    assert_response :success
  end

  test "should get show" do
    get returns_show_url
    assert_response :success
  end

  test "should get create" do
    get returns_create_url
    assert_response :success
  end

  test "should get update" do
    get returns_update_url
    assert_response :success
  end
end
