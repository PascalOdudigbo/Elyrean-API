require "test_helper"

class RefundsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get refunds_index_url
    assert_response :success
  end

  test "should get show" do
    get refunds_show_url
    assert_response :success
  end

  test "should get create" do
    get refunds_create_url
    assert_response :success
  end

  test "should get update" do
    get refunds_update_url
    assert_response :success
  end
end
