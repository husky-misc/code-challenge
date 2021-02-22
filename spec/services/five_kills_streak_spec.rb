require 'rails_helper'

RSpec.describe FiveKillsStreak do
  let!(:match) { create(:match) }
  let!(:player_1) { create(:player) }
  subject { FiveKillsStreak.new(player_1, match.id) }

  context "for 5 kills in one minute" do
    let!(:frag_1) { create(:frag, player: player_1, match: match) }
    let!(:frag_2) { create(:frag, player: player_1, match: match) }
    let!(:frag_3) { create(:frag, player: player_1, match: match) }
    let!(:frag_4) { create(:frag, player: player_1, match: match) }
    let!(:frag_5) { create(:frag, player: player_1, match: match) }
  
    it 'gives award' do
      expect(subject.award).to be_truthy
    end
  end

  context "Given 6 kills" do
    let!(:frag_1) { create(:frag, player: player_1, match: match, date: Time.now - 1.minutes) }
    let!(:death) { create(:death, player: player_1, match: match, date: Time.now - 45.seconds) }
    let!(:frag_2) { create(:frag, player: player_1, match: match, date: Time.now + 2.minutes) }
    let!(:frag_3) { create(:frag, player: player_1, match: match, date: Time.now + 2.minutes) }
    let!(:frag_4) { create(:frag, player: player_1, match: match, date: Time.now + 2.minutes) }
    let!(:frag_5) { create(:frag, player: player_1, match: match, date: Time.now + 2.minutes) }
    let!(:frag_6) { create(:frag, player: player_1, match: match, date: Time.now + 2.minutes) }

    it "Returns award starting streak at sixth kill" do
      expect(subject.award).to be_truthy
    end
  end

  context "Given 10 kills" do
    let!(:frag_1) { create(:frag, player: player_1, match: match, date: Time.now + 1.minutes) }
    let!(:frag_2) { create(:frag, player: player_1, match: match, date: Time.now + 1.minutes) }
    let!(:frag_3) { create(:frag, player: player_1, match: match, date: Time.now + 1.minutes) }
    let!(:frag_4) { create(:frag, player: player_1, match: match, date: Time.now + 1.minutes) }
    let!(:frag_5) { create(:frag, player: player_1, match: match, date: Time.now + 1.minutes) }
    let!(:frag_6) { create(:frag, player: player_1, match: match, date: Time.now + 2.minutes) }
    let!(:frag_7) { create(:frag, player: player_1, match: match, date: Time.now + 2.minutes) }
    let!(:frag_8) { create(:frag, player: player_1, match: match, date: Time.now + 2.minutes) }
    let!(:frag_9) { create(:frag, player: player_1, match: match, date: Time.now + 2.minutes) }
    let!(:frag_10) { create(:frag, player: player_1, match: match, date: Time.now + 2.minutes) }

    it "Returns award for all frags" do
      expect(subject.award).to be_truthy
    end
  end
end