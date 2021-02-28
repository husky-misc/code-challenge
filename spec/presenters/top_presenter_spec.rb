require 'rails_helper'

RSpec.describe Matches::TopPresenter do
  include Rails.application.routes.url_helpers

  describe '.attributes' do
    context 'when there are top killer players' do
      let(:killer)        { create(:player) }
      let(:victim)        { create(:player) }
      let(:match)         { create(:finished_match) }
      let(:players)       { Matches::BestPlayersRepository.players }
      let(:presenter)     { Matches::TopPresenter.new(players).attributes }
      let(:first_player)  { presenter.first }
      let(:second_player) { presenter.last }

      before do
        create_list(:play, 2, killer: killer, victim: victim, match: match)
      end

      it 'expects formatted first player attributes' do
        expect(first_player[:nickname]).to eq killer.nickname
        expect(first_player[:position]).to eq 1
      end
    end

    context 'when players is empty' do
      let(:presenter) { Matches::TopPresenter.new([]).attributes }

      it 'expects presenter do be empty' do
        expect(presenter).to be_empty
      end
    end
  end
end
