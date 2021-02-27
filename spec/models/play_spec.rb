require 'rails_helper'

RSpec.describe Play, type: :model do
  let(:match)    { create(:finished_match) }
  let(:killer)   { create(:player) }
  let(:victim)   { create(:player) }
  let(:weapon)   { create(:weapon) }
  let(:gametime) { match.start + 1.second }

  context 'when param match is not present' do
    let(:new_play) do
      build(:play, match: nil, killer: killer, victim: victim, weapon: weapon, gametime: gametime)
    end

    it 'expects to not be valid' do
      expect(new_play).not_to be_valid
    end

    it 'expects to not save' do
      expect(new_play.save).to be false
    end
  end

  context 'when param gametime is not present' do
    let(:new_play) do
      build(:play, match: match, killer: killer, victim: victim, weapon: weapon, gametime: nil)
    end

    it 'expects to not be valid' do
      expect(new_play).not_to be_valid
    end

    it 'expects to not save' do
      expect(new_play.save).to be false
    end
  end

  context 'when there are no missing params' do
    let(:new_play) do
      build(:play, match: match, killer: killer, victim: victim, weapon: weapon, gametime: gametime)
    end

    it 'expects to not be valid' do
      expect(new_play).to be_valid
    end

    it 'expects to not save' do
      expect(new_play.save).to be true
    end

    it 'expects to create a new play row in datbase' do
      expect { new_play.save }.to change(Play, :count).by(1)
    end
  end

  context 'when params killer and weapon is missing' do
    let(:new_play) do
      build(:play, match: match, killer: nil, victim: victim, weapon: nil, gametime: gametime)
    end

    it 'expects new_play to be valid' do
      expect(new_play).to be_valid
    end

    it 'expects new_play to be saved in database' do
      expect(new_play.save).to be true
    end
  end
end
