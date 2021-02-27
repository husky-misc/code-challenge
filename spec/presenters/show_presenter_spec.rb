require 'rails_helper'

RSpec.describe Matches::ShowPresenter do
  include Rails.application.routes.url_helpers

  describe '.attributes' do
    context 'when plays is empty' do
      let(:presenter) { Matches::ShowPresenter.new([]).attributes }

      it 'expects to raise ActiveModel::ValidationError' do
        expect { presenter }.to(
          raise_error(
            ActiveModel::ValidationError,
            'Validation failed: Plays can\'t be blank'
          )
        )
      end
    end

    context 'when matches is present' do
      let(:weapon)      { create(:weapon) }
      let(:killer)      { create(:player) }
      let(:victim)      { create(:player) }
      let(:some_match)  { create(:finished_match) }
      let(:match_plays) { Matches::MatchRepository.match_plays(some_match.id) }
      let(:presenter)   { Matches::ShowPresenter.new(match_plays).attributes }

      before do
        create(:play, match: some_match, weapon: weapon, killer: killer, victim: victim)
      end

      describe 'expects the formatted data' do
        let(:match_id)           { presenter[:match_id] }
        let(:winner_player_data) { presenter[:players].first }
        let(:loser_player_data)  { presenter[:players].last }

        it 'expects the right match_id' do
          expect(match_id).to eq some_match.match_id
        end

        it 'expects right attributes from winner player' do
          expect(winner_player_data[:nickname]).to eq killer.nickname
          expect(winner_player_data[:kills]).to eq 1
          expect(winner_player_data[:deaths]).to eq 0
          expect(winner_player_data[:awards]).to eq ['Imorrível', "Rei da #{weapon.name}"]
        end

        it 'expects right attributes from loser player' do
          expect(loser_player_data[:nickname]).to eq victim.nickname
          expect(loser_player_data[:kills]).to eq 0
          expect(loser_player_data[:deaths]).to eq 1
          expect(loser_player_data[:awards]).to eq []
        end
      end
    end
  end
end
