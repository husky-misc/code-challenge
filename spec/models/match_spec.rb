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
end
