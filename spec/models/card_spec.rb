# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Card, type: :model do
  describe '.build' do
    context 'when building a card' do
      let(:card_string) { '9D' }
      let(:card) { described_class.build(card_string) }

      it "finds the card's face" do
        expect(card.face).to be 9
      end

      it "finds the card's suit" do
        expect(card.suit).to be 1
      end
    end
  end

  describe '#validations' do
    context 'when input has 3 characters' do
      let(:card_string) { '9DD' }

      it 'raises error' do
        expect { described_class.build(card_string) }.to raise_error(Card::InvalidCard)
      end
    end

    context 'when input has unknown face' do
      let(:card_string) { 'LD' }

      it 'raises error' do
        expect { described_class.build(card_string) }.to raise_error(Card::InvalidCard)
      end
    end

    context 'when input has unknown suit' do
      let(:card_string) { 'AA' }

      it 'raises error' do
        expect { described_class.build(card_string) }.to raise_error(Card::InvalidCard)
      end
    end
  end
end
