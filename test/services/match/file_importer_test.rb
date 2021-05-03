require "test_helper"

class Match::FileImporterTest < ActiveSupport::TestCase
  test ".import" do
    assert_difference ->{ Match.count } => 4, ->{ Kill.count } => 22, ->{ Player.count } => 21, ->{ Weapon.count } => 2 do
      Match::FileImporter.call(file_fixture("matches"))
    end
  end

  test ".import should fail" do
    assert_difference ->{ Match.count } => 0, ->{ Kill.count } => 0, ->{ Player.count } => 0, ->{ Weapon.count } => 0 do
      assert_raises Match::Creator::PlayersLimitExceededError do
        Match::FileImporter.call(file_fixture("invalid-matches"))
      end
    end
  end
end
