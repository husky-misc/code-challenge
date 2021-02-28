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
end
