# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokerHands::Straight do
  describe '#priority' do
    context 'when poker hands is defined for the parent class' do
      it 'returns 5' do
        expect(described_class.priority).to eq 5
      end
    end
  end

  describe '#possible?' do
    subject { described_class.possible?({ sorted: hand.sorted }) }

    let(:deck_line) { 'AC 2D 9C 3S KD 5S 4D KS AS 4C' }
    let(:hand) { Hand.build(deck_line) }

    context 'when the hand has five cards consecutives' do
      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'when a sequence exists using aces after kings' do
      let(:deck_line) { 'AC 2D QC 7S KD 5S JD KS TS 4C' }

      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'when it does not exists sequence in the hand' do
      let(:deck_line) { 'AC 2D 9C 7S KD 5S 7D KS AS 4C' }

      it 'returns false' do
        expect(subject).to be_falsy
      end
    end
  end
end
