# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Games::Logs::Matches::Extract do
  let(:game) { create(:game) }

  describe '#all_matches' do
    let(:all_matches) { described_class.new(game).all_matches }
    context 'when log have contents' do
      it 'returns the matches from the log' do
        expect(all_matches.size).to eq(2)
        expect(all_matches.first.first[:event]).to eq('New match 1 has started')
        expect(all_matches.first.first.keys).to eq(%i[datetime event])
        expect(all_matches.second.first[:event]).to eq('New match 2 has started')
        expect(all_matches.first.first.keys).to eq(%i[datetime event])
      end
    end
  end
end
