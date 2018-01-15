require 'test_helper'

class ComputesHistoryControllerTest < ActionDispatch::IntegrationTest

  setup do
    6.times do
      post "/store", params: { address: "127.0.0.1", numbers: [1,2,3] }, as: :json
      get "/compute"
    end
  end
  test "should get all compute history" do
    get "/compute_history"

    assert_equal(6, response.parsed_body["history"].count)
    assert_response :success
  end

  test "should get five compute history with pagination" do
    get "/compute_history?page[number]=1"

    assert_equal(5, response.parsed_body["history"].count)
    assert_response :success
  end

  test "should get one compute history with pagination" do
    get "/compute_history?page[number]=2"

    assert_equal(1, response.parsed_body["history"].count)
    assert_response :success
  end
end
