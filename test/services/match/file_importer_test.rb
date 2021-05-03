require "test_helper"

class Match::FileImporterTest < ActiveSupport::TestCase
  test ".import" do
    assert_difference ->{ Match.count } => 4, ->{ Kill.count } => 22, ->{ Player.count } => 21, ->{ Weapon.count } => 2 do
      Match::FileImporter.call(file_fixture("matches"))
    end
  end

  test ".import should fail" do
    assert_difference ->{ Match.count } => 0, ->{ Kill.count } => 0, ->{ Player.count } => 0, ->{ Weapon.count } => 0 do
      assert_raises ActiveRecord::RecordInvalid do
        Match::FileImporter.call(file_fixture("invalid-matches"))
      end
    end
  end

  test ".import more than players limit" do
    Match::FileImporter.call(file_fixture("matches"))

    match_with_players_limit_reached = Match.find_by(code: 11348777)
    kill = match_with_players_limit_reached.kills.build(killed_at: Time.now, killed: players(:one))

    refute kill.valid?
    refute match_with_players_limit_reached.valid?
  end
end
