# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokerHands::StraightFlush do
  describe '#priority' do
    context 'when poker hands is defined for the parent class' do
      it 'returns 1' do
        expect(described_class.priority).to eq 1
      end
    end
  end

  describe '#possible?' do
    subject { described_class.possible?({ sorted: hand.sorted, by_suit: hand.grouped_by_suit }) }

    let(:deck_line) { 'TC 2D 9C 3S KD 5S QC KC AS JC' }
    let(:hand) { Hand.build(deck_line) }

    context 'when the hand has five cards consecutives with the same suit' do
      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'when a sequence exists using aces after kings' do
      let(:deck_line) { 'AC 2D QC 7S KC 5S JC KS TC 4C' }

      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'when it does exists sequence in the hand in more than one suit' do
      let(:deck_line) { '6C 2D 9C 7S KD 5S 7D 3S AS 4C' }

      it 'returns false' do
        expect(subject).to be_falsy
      end
    end

    context 'when it has cards on same suit' do
      let(:deck_line) { 'AC 2C 9C 7C KC 5C 8C QC TC 4C' }

      it 'returns false' do
        expect(subject).to be_falsy
      end
    end

    context 'when it does not exists sequence' do
      let(:deck_line) { 'AC 2D 9C 7S KD 5S 7D KS AS 4C' }

      it 'returns false' do
        expect(subject).to be_falsy
      end
    end
  end
end
