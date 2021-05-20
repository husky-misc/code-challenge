# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HandEvaluator do
  describe '.call' do
    subject { described_class.new(hand) }

    context 'when deck is valid' do
      let(:deck_line) { 'TH JH QC QD QS QH KH AH 2S 6S' }
      let(:hand) { Hand.build(deck_line) }
      let(:expected) do
        {
          hand: 'TH JH QC QD QS',
          deck: 'QH KH AH 2S 6S',
          best_hand: 'straight-flush'
        }
      end

      it 'retuns a string with best hand' do
        expect(subject.call).to eq expected
      end
    end

    context 'when deck has invalid entries' do
      let(:deck_line) { 'AX JH QC QD QS QH KH AH 2S 6S' }
      let(:hand) { Hand.build(deck_line) }

      it 'retuns an error' do
        expect { subject.call }.to raise_error(Card::InvalidCard)
      end
    end
  end

  describe '.best_hand' do
    subject { described_class.new(hand) }

    context 'when found a straight flush' do
      let(:deck_line) { 'TH JH QC QD QS QH KH AH 2S 6S' }
      let(:hand) { Hand.build(deck_line) }

      before do
        allow(PokerHands::StraightFlush).to receive(:possible?).and_return(true)
        allow(PokerHands::FourOfAKind).to receive(:possible?)
        allow(PokerHands::HighestCard).to receive(:possible?)
      end

      it 'stops evaluating hands when finding first' do
        subject.best_hand

        expect(PokerHands::StraightFlush).to have_received(:possible?)
        expect(PokerHands::FourOfAKind).not_to have_received(:possible?)
        expect(PokerHands::HighestCard).not_to have_received(:possible?)
      end
    end
  end
end
