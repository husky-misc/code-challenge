require 'rails_helper'

RSpec.describe Matches::IndexPresenter do
  include Rails.application.routes.url_helpers

  describe '.attributes' do
    context 'when matches is an empty array' do
      let(:presenter) { Matches::IndexPresenter.new([]).attributes }

      it 'expects to to be an empty_array' do
        expect(presenter).to be_empty
      end
    end

    context 'when matches is present' do
      let(:weapon)     { create(:weapon) }
      let(:killer)     { create(:player) }
      let(:some_match) { create(:finished_match) }
      let(:matches)    { Matches::ResumeRepository.matches }
      let(:presenter)  { Matches::IndexPresenter.new(matches).attributes }

      before do
        create(:play, match: some_match, weapon: weapon, killer: killer)
      end

      it 'expects the formatted data' do
        presenter.map do |match|
          expect(match[:match][:id]).to eq some_match.match_id
          expect(match[:match][:show_path]).to eq match_path(some_match)
          expect(match[:best_player]).to eq killer.nickname
          expect(match[:most_used_weapon]).to eq weapon.name
        end
      end
    end
  end
end
