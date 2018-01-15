require 'test_helper'

class IpTest < ActiveSupport::TestCase
  setup do
    @ip = Ip.create(address: "127.0.0.1")
    @ip.numbers = [Number.create(value: 9), Number.create(value: 1), Number.create(value: 3)]
  end

  test "should print numbers_value correct" do
    numbers_value = @ip.numbers_value
    assert_equal([1,3,9], numbers_value)
  end

end
