# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokerHands::TwoPairs do
  describe '#priority' do
    context 'when poker hands is defined for the parent class' do
      it 'returns 7' do
        expect(described_class.priority).to eq 7
      end
    end
  end

  describe '#possible?' do
    subject(:possible?) { described_class.possible?({ by_face: grouped_by_face }) }

    context 'when the hand as four cards with same face' do
      let(:grouped_by_face) { [{ face: 2, qty: 2 }, { face: 4, qty: 2 }] }

      it 'returns true' do
        expect(possible?).to be_truthy
      end
    end

    context 'when the group has no cases of four cards with the same face' do
      let(:grouped_by_face) { [{ face: 3, qty: 1 }, { face: 13, qty: 2 }] }

      it 'returns false' do
        expect(possible?).to be_falsy
      end
    end
  end
end
