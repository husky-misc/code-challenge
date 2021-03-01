# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Games::Logs::Matches::Data do
  let(:game) { create(:game) }
  let(:matches) { Games::Logs::Matches::Extract.new(game).all_matches }
  let(:match) { matches.first }
  let(:data) { described_class.new(match) }

  describe '#events_list' do
    let(:events_data) { data.events_list }
    it 'returns the events list' do
      expect(events_data.size).to eq(7)
    end
  end

  describe '#id' do
    it 'returns id' do
      expect(data.id).to eq('1')
    end
  end

  describe '#started_at' do
    it 'returns match started_at' do
      expect(data.started_at).to eq('23/04/2013 15:34:22')
    end
  end

  describe '#finished_at' do
    it 'returns match finished_at' do
      expect(data.finished_at).to eq('23/04/2013 15:39:22')
    end
  end

  describe '#players' do
    it 'returns match players' do
      expect(data.players.size).to eq(8)
      expect(data.players).to eq(%w[Roman Nick Marcus Astrobaldo Robertinho Zangief Diego Osw])
    end
  end

  describe '#ranking' do
    it 'returns the match rating by frags' do
      expect(data.ranking.size).to eq(8)
      expect(data.ranking.first[:name]).to eq('Roman')
      expect(data.ranking.first[:frags]).to eq(5)
      expect(data.ranking.first[:deaths]).to eq(0)
      expect(data.ranking.first[:award]).to eq(true)
      expect(data.ranking.first[:streak]).to eq(5)
      expect(data.ranking.first[:weapon]).to eq('knife')
      expect(data.ranking.last[:name]).to eq('Osw')
      expect(data.ranking.last[:frags]).to eq(0)
      expect(data.ranking.last[:deaths]).to eq(1)
      expect(data.ranking.last[:award]).to eq(false)
      expect(data.ranking.last[:streak]).to eq(0)
      expect(data.ranking.last[:weapon]).to eq('no kills, no factal weapon')
    end
  end
end
