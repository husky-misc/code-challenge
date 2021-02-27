require 'rails_helper'

RSpec.describe Players::GameDeathsRepository do
  let(:repository)    { Players::GameDeathsRepository }
  let(:match)         { create(:finished_match) }
  let(:victim)        { create(:player) }
  let(:random_victim) { create(:player) }

  context 'when player died sometimes' do
    before do
      create(:play, victim: victim, match: match)
    end

    it 'expects the return value to be equals player deaths' do
      expect(repository.deaths(match, victim).positive?).to be true
    end
  end

  context 'when player didn\'t die' do
    before do
      create(:play, victim: random_victim)
    end

    it 'expects the return value to be zero' do
      expect(repository.deaths(match, victim).zero?).to be true
    end
  end

  context 'when match param is not present' do
    before do
      create(:play, victim: victim)
    end

    it 'expects the return value to be zero' do
      expect(repository.deaths(nil, victim).zero?).to be true
    end
  end

  context 'when victim param is not present' do
    before do
      create(:play, victim: victim)
    end

    it 'expects the return value to be zero' do
      expect(repository.deaths(match, nil).zero?).to be true
    end
  end
end