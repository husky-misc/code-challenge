# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Games::Logs::Matches::Ranking do
  let(:game) { create(:game) }
  let(:matches) { Games::Logs::Matches::Extract.new(game).all_matches }
  let(:match) { Games::Logs::Matches::Data.new(matches.first) }
  let(:players) { match.players }
  let(:events) { match.events_list }
  let(:ranking) { Games::Logs::Matches::Ranking.new(players, events) }

  describe '#frags' do
    it 'returns the frags list' do
      expect(ranking.frags.size).to eq(3)
    end
  end

  describe '#frags_count' do
    it 'returns the frags count' do
      expect(ranking.frags_count.size).to eq(3)
      expect(ranking.frags_count['Roman']).to eq(5)
      expect(ranking.frags_count['Diego']).to eq(1)
      expect(ranking.frags_count['<WORLD>']).to eq(1)
    end
  end

  describe '#frags?' do
    it 'returns true if player has frag' do
      expect(ranking.frags?('Roman')).to eq(true)
    end

    it 'returns false if player dont has frag' do
      expect(ranking.frags?('Astrobaldo')).to eq(false)
    end
  end
end
