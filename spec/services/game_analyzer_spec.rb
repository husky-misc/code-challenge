# frozen_string_literal: true

RSpec.describe GameAnalyzer do
  describe '.call' do
    context 'when deck is valid' do
      it 'searches the best hand for each deck'
    end

    context 'when deck contains invalid cards' do
      it 'appends and error message to deck line'
    end

    context 'when deck contains wrong amount of cards' do
      it 'appends and error message to deck'
    end
  end
end
