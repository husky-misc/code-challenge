# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokerHands::ThreeOfAKind do
  describe '#priority' do
    context 'when poker hands is defined for the parent class' do
      it 'returns 6' do
        expect(described_class.priority).to eq 6
      end
    end
  end

  describe '#possible?' do
    subject(:possible?) { described_class.possible?({ by_face: grouped_by_face }) }

    context 'when the hand has three cards with same face' do
      let(:grouped_by_face) { [{ face: 2, qty: 3 }] }

      it 'returns true' do
        expect(possible?).to be_truthy
      end
    end

    context 'when the group has no cases of three cards with the same face' do
      let(:grouped_by_face) { [{ face: 3, qty: 2 }, { face: 13, qty: 2 }] }

      it 'returns false' do
        expect(possible?).to be_falsy
      end
    end
  end
end
