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
end
