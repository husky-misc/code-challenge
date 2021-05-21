# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokerHands::OnePair do
  describe '#priority' do
    context 'when poker hands is defined for the parent class' do
      it 'returns 8' do
        expect(described_class.priority).to eq 8
      end
    end
  end

  describe '#possible?' do
    subject { described_class.possible?({ by_face: grouped_by_face }) }

    context 'when the hand has two cards with same face' do
      let(:grouped_by_face) { [{ face: 2, qty: 2 }] }

      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'when the group has no cases of two cards with the same face' do
      let(:grouped_by_face) { [{ face: 3, qty: 1 }, { face: 13, qty: 1 }] }

      it 'returns false' do
        expect(subject).to be_falsy
      end
    end
  end
end
