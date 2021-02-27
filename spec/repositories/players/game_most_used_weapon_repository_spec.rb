require 'rails_helper'

RSpec.describe Players::GameMostUsedWeaponRepository do
  let(:repository) { Players::GameMostUsedWeaponRepository }
  let(:match)      { create(:finished_match) }
  let(:weapon)     { create(:weapon) }
  let(:killer)     { create(:player) }

  before do
    create_list(:play, 3, killer: killer, weapon: weapon, match: match)
  end

  context 'when param match is not present' do
    it 'expects to to retrieve most used weapon from winner' do
      expect(repository.most_used_weapon_from_winner(nil, killer)).not_to eq weapon
    end

    it 'expects to return nil' do
      expect(repository.most_used_weapon_from_winner(nil, killer)).to be nil
    end
  end

  context 'when param winner is not present' do
    it 'expects to not retrieve most used weapon from winner' do
      expect(repository.most_used_weapon_from_winner(match, nil)).not_to eq weapon
    end

    it 'expects to return nil' do
      expect(repository.most_used_weapon_from_winner(match, nil)).to be nil
    end
  end

  context 'when winner is found' do
    it 'expects to retrieve his most used weapon in game' do
      expect(repository.most_used_weapon_from_winner(match, killer)).to eq weapon
    end
  end
end
