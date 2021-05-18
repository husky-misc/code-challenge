# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games', type: :request do
  describe 'POST /games_upload' do
    context 'when all cards are valid' do
      let(:games_filename) { file_fixture('valid_games.txt') }
      let(:games_result) do
        [
          { hand: 'TH JH QC QD QS', deck: 'QH KH AH 2S 6S', best_hand: :straight_flush },
          { hand: '2H 2S 3H 3S 3C', deck: '2D 3D 6C 9C TH', best_hand: :four_of_a_kind },
          { hand: '2H 2S 3H 3S 3C', deck: '2D 9C 3D 6C TH', best_hand: :full_house },
          { hand: '2H AD 5H AC 7H', deck: 'AH 6H 9H 4H 3C', best_hand: :flush },
          { hand: 'AC 2D 9C 3S KD', deck: '5S 4D KS AS 4C', best_hand: :straight },
          { hand: 'KS AH 2H 3C 4H', deck: 'KC 2C TC 2D AS', best_hand: :three_of_a_kind },
          { hand: 'AH 2C 9S AD 3C', deck: 'QH KS JS JD KD', best_hand: :two_pairs },
          { hand: '6C 9C 8C 2D 7C', deck: '2H TC 4C 9S AH', best_hand: :one_pair },
          { hand: '3D 5S 2H QD TD', deck: '6S KH 9H AD QH', best_hand: :highest_card }
        ]
      end

      before do
        allow(GameAnalyzer).to receive(:call).and_return(games_result)

        post games_upload_path, params: { games_filename: games_filename }
      end

      it 'loads a partial with the results' do
        expect(response.body).to include(I18n.t('games.index.title'))
        expect(response.body).to include(I18n.t('games.result.results'))
      end
    end

    context 'when file format is invalid' do
      before { post games_upload_path, params: { games_filename: 'invalid_file.png' } }

      it 'raises an error' do
        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to include(I18n.t('.games.upload.unprocessable_file'))
      end
    end
  end
end
