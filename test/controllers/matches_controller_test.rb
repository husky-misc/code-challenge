require "test_helper"

class MatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get matches_index_url
    assert_response :success
  end

  test "should get new" do
    get matches_new_url
    assert_response :success
  end

  test "should get create" do
    get matches_create_url
    assert_response :success
  end
end
