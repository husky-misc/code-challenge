require 'rails_helper'

RSpec.describe Players::GameUnkillableRepository do
  let(:repository) { Players::GameUnkillableRepository }
  let(:match)      { create(:finished_match) }
  let(:weapon)     { create(:weapon) }
  let(:killer)     { create(:player) }

  context 'when player didn\'t die' do
    before do
      create_list(:play, 3, killer: killer, weapon: weapon, match: match)
    end

    it 'expects return that player is unkillable' do
      expect(repository.player_unkillable?(match, killer)).to be true
    end
  end

  context 'when player already died in the match' do
    before do
      create_list(:play, 3, victim: killer, weapon: weapon, match: match)
    end

    it 'expects to return that player is not unkillable' do
      expect(repository.player_unkillable?(match, killer)).to be false
    end
  end

  context 'when parameter match is not present' do
    it 'expects to return nil' do
      expect(repository.player_unkillable?(nil, killer)).to be nil
    end
  end

  context 'when parameter victim is not present' do
    it 'expects to return nil' do
      expect(repository.player_unkillable?(match, nil)).to be nil
    end
  end
end
