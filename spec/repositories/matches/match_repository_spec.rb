require 'rails_helper'

RSpec.describe Matches::MatchRepository do
  let(:repository) { Matches::MatchRepository }
  let(:match)      { create(:finished_match) }
  let(:match_id)   { match.id }

  before do
    create(:play, match: match)
  end

  context 'when match id param is not present' do
    it 'expects to not find any play' do
      expect(repository.match_plays(nil)).to be_empty
    end
  end

  context 'when match does not exists in database' do
    let(:random_number) { Faker::Number.number(digits: 12).to_s }

    it 'expects to not find any play' do
      expect(repository.match_plays(random_number)).to be_empty
    end
  end

  context 'when match id is found in database' do
    let(:find_match_plays) { repository.match_plays(match_id) }

    it 'expects to retrieve match plays from database' do
      expect(find_match_plays).not_to be_empty
    end

    it 'expects to retrieve plays from right match' do
      find_match_plays.each do |play|
        expect(play.match).to eq(match)
      end
    end
  end
end
