# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokerHands::Flush do
  describe '#priority' do
    context 'when poker hands is defined for the parent class' do
      it 'returns 4' do
        expect(described_class.priority).to eq 4
      end
    end
  end

  describe '#possible?' do
    subject(:possible?) { described_class.possible?({ by_suit: grouped_by_suit }) }

    context 'when the hand has fiver cards with same suit' do
      let(:grouped_by_suit) { [{ suit: 2, qty: 5 }] }

      it 'returns true' do
        expect(possible?).to be_truthy
      end
    end

    context 'when the group has less than five cards with the same suit' do
      let(:grouped_by_suit) { [{ suit: 3, qty: 3 }, { suit: 2, qty: 2 }] }

      it 'returns false' do
        expect(possible?).to be_falsy
      end
    end
  end
end
