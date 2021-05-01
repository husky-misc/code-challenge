require "test_helper"

class Match::RankQueryTest < ActiveSupport::TestCase
  test "rank" do
    match = matches(:one)

    rank = Match::RankQuery.new(match).call

    assert_equal [["Player 01", 1, 0], ["Player 02", 0, 1]], rank
  end
end
