require "test_helper"

class MatchTest < ActiveSupport::TestCase
  test ".import" do
    assert_difference ->{ Match.count } => 3, ->{ Kill.count } => 9, ->{ Player.count } => 6, ->{ Weapon.count } => 2 do
      Match.import(file: file_fixture("matches"))
    end
  end
end
