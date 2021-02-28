require 'rails_helper'

RSpec.describe Players::GameWinnerRepository do
  let(:repository) { Players::GameWinnerRepository }
  let(:match)      { create(:finished_match) }
  let(:weapon)     { create(:weapon) }
  let(:killer)     { create(:player) }

  context 'when player is the winner' do
    before do
      create_list(:play, 3, killer: killer, weapon: weapon, match: match)
    end

    it 'expects to return the winner player' do
      expect(repository.winner(match)).to eq killer
    end
  end

  context 'when parameter match is not present' do
    it 'expects to return nil' do
      expect(repository.winner(nil)).to be nil
    end
  end
end
