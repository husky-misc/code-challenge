require 'rails_helper'

RSpec.describe Matches::BestPlayersRepository do
  let(:repository)   { Matches::BestPlayersRepository }
  let(:killer1)      { create(:player) }
  let(:killer2)      { create(:player) }

  describe '.players' do
    context 'when there are players registered' do
      before do
        create_list(:play, 3, killer: killer1)
        create_list(:play, 2, killer: killer2)
      end

      it 'expect to retrieve best players' do
        expect(repository.players).to include killer1
        expect(repository.players).to include killer2
      end
    end

    context 'when there are no players registered' do
      it 'expect to return an empty array' do
        expect(repository.players).to be_empty
      end
    end
  end
end
