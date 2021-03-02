# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreMatchService do
  let(:game) { create(:game) }
  let(:store_matches) { StoreMatchService.call(game) }
  let(:match_one) { store_matches.first.first[:event] }
  let(:match_two) { store_matches.last.first[:event] }

  describe '#call' do
    it 'return matches' do
      expect(store_matches.size).to eq(2)
      expect(match_one).to eq('New match 1 has started')
      expect(match_two).to eq('New match 2 has started')
    end
  end
end
