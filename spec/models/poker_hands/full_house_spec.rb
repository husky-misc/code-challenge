# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokerHands::FullHouse do
  describe '#priority' do
    context 'when poker hands is defined for the parent class' do
      it 'returns 3' do
        expect(described_class.priority).to eq 3
      end
    end
  end

  describe '#possible?' do
    subject { described_class.possible?({ by_face: grouped_by_face }) }

    context 'when the hand has one pair and one three of a kind' do
      let(:grouped_by_face) { [{ face: 2, qty: 3 }, { face: 7, qty: 2 }] }

      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'when the hand has at least one pair and one three of a kind' do
      let(:grouped_by_face) { [{ face: 2, qty: 3 }, { face: 7, qty: 3 }, { face: 9, qty: 3 }] }

      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'when the group has no pair and three in the same hand' do
      let(:grouped_by_face) { [{ suit: 3, qty: 2 }, { suit: 2, qty: 2 }] }

      it 'returns false' do
        expect(subject).to be_falsy
      end
    end
  end
end
