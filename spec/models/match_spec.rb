require 'rails_helper'

RSpec.describe Match, type: :model do
  context 'when there are no other match with the same match_id' do
    let(:match) { build(:started_match) }

    it 'expects to be valid' do
      expect(match).to be_valid
    end

    it 'expects to save the new match' do
      expect(match.save).to be true
    end
  end

  context 'when there is a saved match with the same match_id' do
    let(:match_id)  { Faker::Number.number(digits: 10).to_s }
    let(:match)     { build(:started_match, match_id: match_id) }

    before do
      create(:finished_match, match_id: match_id)
    end

    it 'expects to not be valid' do
      expect(match).not_to be_valid
    end

    it 'expects to not save the new match' do
      expect(match.save).to be false
    end
  end

  context 'when match reached the maxium amount of players' do
    let(:some_match) { create(:started_match) }
    let(:finished)   { some_match.start + 2.minutes }
    let(:play)       { build(:play, match: some_match) }

    before do
      create_list(:play, 10, match: some_match)
    end

    it 'expects to raise an validation error' do
      expect { some_match.update!(finish: finished) }.to(
        raise_error(
          StandardError,
          'The maximun amount of players was reached'
        )
      )
    end
  end
end
