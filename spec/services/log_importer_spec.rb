require "rails_helper"

RSpec.describe "Log Importer", type: :model do
  describe "initialize" do
    it "defines data list and errors" do
      # Setup
      valid_data = <<-LOG
      23/04/2013 15:34:22 - New match 11348965 has started
      23/04/2013 15:36:04 - Roman killed Nick using M16
      23/04/2013 15:36:33 - <WORLD> killed Nick by DROWN
      23/04/2013 15:39:22 - Match 11348965 has ended
      LOG

      # Exercise
      log_importer = LogImporter.new(valid_data)

      # Assertions
      expect(log_importer.errors).to eq([])
      expect(log_importer.data).to be_an(Array)
      expect(log_importer.data.length).to eq(4)
    end
  end

  describe "parse_data" do
    context "when valid log is provided" do
      it "parses the data and store in parsed_data attribute" do
        # Setup
        valid_data = <<-LOG
        23/04/2013 15:34:22 - New match 11348965 has started
        23/04/2013 15:36:04 - Roman killed Nick using M16
        23/04/2013 15:36:33 - <WORLD> killed Nick by DROWN
        23/04/2013 15:39:22 - Match 11348965 has ended
        LOG

        # Exercise
        log_importer = LogImporter.new(valid_data)
        log_importer.parse_data()

        # Assertions
        expect(log_importer.valid?).to be_truthy
        expect(log_importer.parsed_data.length).to eq(4)
      end
    end

    context "when invalid log is provided" do
      it "have errors" do
        # Setup
        invalid_data = <<-LOG
        23/04/2013 15:34:22 - New competition 11348965 has initialized
        23/04/2013 15:36:04 - Roman murdered Nick using M16
        23/04/2013 15:36:33 - <WORLD> murdered Nick by DROWN
        23/04/2013 15:39:22 - Match 11348965 has ended
        LOG

        # Exercise
        log_importer = LogImporter.new(invalid_data)
        log_importer.parse_data()

        # Assertions
        expect(log_importer.valid?).to be_falsey
        expect(log_importer.errors).to match_array([
          "Invalid data on line 1",
          "Invalid data on line 2",
          "Invalid data on line 3"
        ])
      end
    end
  end

  describe "save!" do
    context "when valid log is provided" do
      it "saves match, players and rounds" do
        # Setup
        valid_data = <<-LOG
        23/04/2013 15:34:22 - New match 11348965 has started
        23/04/2013 15:36:04 - Roman killed Nick using M16
        23/04/2013 15:36:33 - <WORLD> killed Nick by DROWN
        23/04/2013 15:39:22 - Match 11348965 has ended
        LOG

        # Exercise
        log_importer = LogImporter.new(valid_data)
        log_importer.parse_data
        log_importer.save!

        players = Player.where(nickname: ["Nick", "Roman"]).all
        match = Match.find_by(external_id: 11348965)

        # Assertions
        expect(players.count).to eq(2)
        expect(match).to be_a(Match)
        expect(match.frags_count).to eq(1)
        expect(match.rounds.count).to eq(1)

        expect(match.rounds.first.action).to eq("kill")
        expect(match.rounds.first.metadata).to eq({
          "killer_player_nickname" => "Roman",
          "dead_player_nickname" => "Nick"
        })
      end
    end
  end
end
