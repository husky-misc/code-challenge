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

  describe '#deaths_count' do
    it 'returns the deaths count' do
      expect(ranking.deaths_count.size).to eq(7)
      expect(ranking.deaths_count['Nick']).to eq(1)
      expect(ranking.deaths_count['Marcus']).to eq(1)
      expect(ranking.deaths_count['Astrobaldo']).to eq(1)
      expect(ranking.deaths_count['Robertinho']).to eq(1)
      expect(ranking.deaths_count['Zangief']).to eq(1)
      expect(ranking.deaths_count['Osw']).to eq(1)
      expect(ranking.deaths_count['Diego']).to eq(1)
    end
  end

  describe '#deaths?' do
    it 'returns false if player has deaths' do
      expect(ranking.deaths?('Roman')).to eq(false)
    end

    it 'returns true if player dont has deaths' do
      expect(ranking.deaths?('Astrobaldo')).to eq(true)
    end
  end

  describe '#player_weapons' do
    it 'returns number of player streaks' do
      expect(ranking.players_weapons.size).to eq(3)
      expect(ranking.players_weapons['Roman']).to eq({ 'knife' => 3, 'R38' => 1, 'kick' => 1 })
      expect(ranking.players_weapons['Diego']).to eq({ 'crossbow' => 1 })
    end
  end

  describe '#kill_five_times_on_a_minute?(player_name)' do
    it 'returns true if player has kill five times on a minute' do
      expect(ranking.kill_five_times_on_a_minute?('Roman')).to eq(true)
    end

    it 'returns false if player dont has kill five times on a minute' do
      expect(ranking.kill_five_times_on_a_minute?('Diego')).to eq(false)
    end
  end

  describe '#award?' do
    it 'returns true if player has award' do
      expect(ranking.award?('Roman')).to eq(true)
    end

    it 'returns false if player dont has award' do
      expect(ranking.award?('Diego')).to eq(false)
    end
  end

  describe '#dont_have_streaks?' do
    it 'returns false if player has streaks' do
      expect(ranking.dont_have_streaks?('Roman')).to eq(false)
    end

    it 'returns true if player dont has streaks' do
      expect(ranking.dont_have_streaks?('Diego')).to eq(true)
    end
  end

  describe '#streaks(player_name)' do
    it 'returns number of player streaks' do
      expect(ranking.streaks('Roman')).to eq(5)
    end
  end

  describe '#factal_weapon(player_name)' do
    it 'returns weapon of the player who killed the most' do
      expect(ranking.factal_weapon('Roman')).to eq('knife')
      expect(ranking.factal_weapon('Diego')).to eq('crossbow')
    end
  end

  describe '#factal_weapon(player_name)' do
    it 'returns weapon of the player who killed the most' do
      expect(ranking.to_a.size).to eq(8)
      expect(ranking.to_a.first[:name]).to eq('Roman')
      expect(ranking.to_a.first[:frags]).to eq(5)
      expect(ranking.to_a.first[:deaths]).to eq(0)
      expect(ranking.to_a.first[:award]).to eq(true)
      expect(ranking.to_a.first[:streak]).to eq(5)
      expect(ranking.to_a.first[:weapon]).to eq('knife')
    end
  end
end
