require "rails_helper"

RSpec.describe "Log Importer", type: :model do

  @valid_data = <<LOG
  23/04/2013 15:34:22 - New match 11348965 has started
  23/04/2013 15:36:04 - Roman killed Nick using M16
  23/04/2013 15:36:33 - <WORLD> killed Nick by DROWN
  23/04/2013 15:39:22 - Match 11348965 has ended
LOG

  @invalid_data = <<LOG
  23/04/2013 15:34:22 - New competition 11348965 has initialized
  23/04/2013 15:36:04 - Roman murdered Nick using M16
  23/04/2013 15:36:33 - <WORLD> murdered Nick by DROWN
  23/04/2013 15:39:22 - Match 11348965 has ended
LOG

  describe "on initialize" do
    context "when valid data is provided" do
      it "defines data list and errors list" do
        log_importer = LogImporter.new(@valid_data)

        expect(log_importer.errors).to be_an(Array)
        expect(log_importer.data).to be_an(Array)

      end
    end

    context "when invalid data is provided" do

    end
  end
end
