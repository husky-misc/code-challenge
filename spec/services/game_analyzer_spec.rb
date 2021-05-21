# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameAnalyzer do
  describe '.call' do
    subject(:call) { described_class.new(games_filename).call }

    context 'when file is valid' do
      let(:games_filename) { file_fixture('valid_games.txt') }

      before do
        allow(HandEvaluator).to receive(:call)
      end

      it 'searches the best hand for each deck' do
        call

        expect(HandEvaluator).to have_received(:call).exactly(9).times
      end
    end

    context 'when returns result' do
      let(:result) { call }
      let(:games_filename) { file_fixture('valid_games.txt') }

      it 'returns an array of results' do
        expect(result.first[:hand]).to eq 'TH JH QC QD QS'
      end
    end

    context 'when file is empty' do
      let(:games_filename) { file_fixture('empty_file.txt') }

      it 'returns NoContentFile exception' do
        expect { call }.to raise_error(GameAnalyzer::NoContentFile)
      end
    end
  end
end
