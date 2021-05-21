# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hand, type: :model do
  describe '#build' do
    context 'when building a hand' do
      let(:deck_line) { 'TH JH QC QD QS QH KH AH 2S 6S' }
      let(:hand) { described_class.build(deck_line) }

      it 'has 10 cards' do
        expect(hand.cards.size).to eq 10
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

  describe 'rearrenging methods' do
    let(:deck_line) { '3H JC QC QD QS QH KH AH 2S 6S' }
    let(:hand) { described_class.build(deck_line) }

    describe '.sorted' do
      context 'when deck contains an ace' do
        it 'has deck sorted by faces' do
          expect(hand.sorted.first.face).to eq 1
          expect(hand.sorted.last.face).to eq 13
        end
      end
    end

    describe '.grouped_by_face' do
      context 'when deck contains four queens' do
        let(:grouped_queens) do
          hand.grouped_by_face.find { |group| group[:face] == 12 }
        end

        it 'has amount of queens' do
          expect(grouped_queens[:qty]).to eq 4
        end
      end
    end

    describe '.grouped_by_suit' do
      context 'when deck contains three cards of hearts' do
        let(:grouped_hearts) do
          hand.grouped_by_suit.find { |group| group[:suit] == 3 }
        end

        it 'has amount of queens' do
          expect(grouped_hearts[:qty]).to eq 4
        end
      end
    end
  end
end
