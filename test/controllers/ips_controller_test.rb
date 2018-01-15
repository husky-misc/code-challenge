require 'test_helper'

class IpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ip = Ip.create(address: "127.0.0.1")
    @ip.numbers = [Number.create(value: 9)]
  end

  test "should create ip" do
    post "/store", params: { address: @ip.address, numbers: [1,2,3] }, as: :json

    assert_response 201
  end

  test "should not create ip with wrong ip address" do
    post "/store", params: { address: "wrong.0.0.1", numbers: [1,2,3] }, as: :json

    assert_response 400
  end

  test "should not create ip with wrong params" do
    post "/store", params: { address: @ip.address }, as: :json

    assert_response 400
  end

  test "should not create ip with request not json" do
    post "/store", params: { address: @ip.address }, as: :xml

    assert_response 415
  end

  test "should compute and show ip address" do
    get "/compute"

    assert_equal([{"address"=>"127.0.0.1", "numbers"=>[9]}], response.parsed_body)
    assert_response 200
  end

  test "should compute and return no content" do
    Ip.destroy_all
    get "/compute"

    assert_response 204
  end

end
