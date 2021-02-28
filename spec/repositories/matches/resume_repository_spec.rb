require 'rails_helper'

RSpec.describe Matches::ResumeRepository do
  let(:repository) { Matches::ResumeRepository }

  context 'when exists recorded matches in database' do
    let(:some_match) { create(:finished_match) }

    it 'expects to load plays from database' do
      play = create(:play, match: some_match)

      repository.matches.each do |match, plays|
        expect(match).to eq(some_match)
        expect(plays).to include play
      end
    end
  end

  context 'when does not exists recorded matchs in database' do
    it 'expects to not load plays from database' do
      expect(repository.matches).to be_empty
    end
  end
end
