require 'rails_helper'

RSpec.describe Players::GameKillsRepository do
  let(:repository)    { Players::GameKillsRepository }
  let(:match)         { create(:finished_match) }
  let(:killer)        { create(:player) }
  let(:random_killer) { create(:player) }

  context 'when player died sometimes' do
    before do
      create(:play, killer: killer, match: match)
    end

    it 'expects the return value to be equals player kills' do
      expect(repository.kills(match, killer).positive?).to be true
    end
  end

  context 'when player didn\'t kill' do
    before do
      create(:play, killer: random_killer)
    end

    it 'expects the return value to be zero' do
      expect(repository.kills(match, killer).zero?).to be true
    end
  end

  context 'when match param is not present' do
    before do
      create(:play, killer: killer)
    end

    it 'expects the return value to be zero' do
      expect(repository.kills(nil, killer).zero?).to be true
    end
  end

  context 'when killer param is not present' do
    before do
      create(:play, killer: killer)
    end

    it 'expects the return value to be zero' do
      expect(repository.kills(match, nil).zero?).to be true
    end
  end
end