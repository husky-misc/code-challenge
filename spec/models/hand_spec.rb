# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hand, type: :model do
  describe '.build' do
    context 'when building a hand' do
      let(:deck_line) { 'TH JH QC QD QS QH KH AH 2S 6S' }
      let(:hand) { described_class.build(deck_line) }

      it 'has 10 cards' do
        expect(hand.deck_by_face.size).to eq 10
      end

      it 'has deck sorted by faces' do
        expect(hand.deck_by_face.first.face).to eq 1
        expect(hand.deck_by_face.first.suit).to eq 3
      end

      it 'has deck sorted by suit' do
        expect(hand.deck_by_suit.first.face).to eq 12
        expect(hand.deck_by_suit.first.suit).to eq 0
      end

      it 'has visible_cards' do
        expect(hand.visible_cards).to eq 'TH JH QC QD QS'
      end
    end
  end

  describe '#validations' do
    context 'when deck line has less then 10 cards' do
      let(:deck_line) { 'JH QC QD QS QH KH AH 2S 6S' }

      it 'raises error' do
        expect { described_class.build(deck_line) }.to raise_error(Hand::InvalidHand)
      end
    end

    context 'when deck line has more then 10 cards' do
      let(:deck_line) { 'AS 2H JH QC QD QS QH KH AH 2S 6S' }

      it 'raises error' do
        expect { described_class.build(deck_line) }.to raise_error(Hand::InvalidHand)
      end
    end

    context 'when deck contains an invalid card' do
      let(:deck_line) { 'AX JH QC QD QS QH KH AH 2S 6S' }

      it 'do what' do
        expect { described_class.build(deck_line) }.to raise_error(Card::InvalidCard)
      end
    end
  end
end
