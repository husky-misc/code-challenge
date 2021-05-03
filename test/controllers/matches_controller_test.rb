require "test_helper"

class MatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get matches_url
    assert_response :success

    assert_select ".match", 2
  end

  test "should show match" do
    match = matches(:one)
    get match_url(match)
    assert_response :success

    assert_select ".kill", 1
  end
end
