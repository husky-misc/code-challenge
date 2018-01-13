require 'test_helper'

class IpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ip = ips(:one)
  end

  test "should get index" do
    get ips_url, as: :json
    assert_response :success
  end

  test "should create ip" do
    assert_difference('Ip.count') do
      post ips_url, params: { ip: { address: @ip.address } }, as: :json
    end

    assert_response 201
  end

  test "should show ip" do
    get ip_url(@ip), as: :json
    assert_response :success
  end

  test "should update ip" do
    patch ip_url(@ip), params: { ip: { address: @ip.address } }, as: :json
    assert_response 200
  end

  test "should destroy ip" do
    assert_difference('Ip.count', -1) do
      delete ip_url(@ip), as: :json
    end

    assert_response 204
  end
end
