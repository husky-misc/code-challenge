require 'rails_helper'

RSpec.describe Match, :type => :model do
    context('Match not ended') do
        it 'Should create a new match' do
            Match.create()
            expect(Match.count).to eq(1)
        end
    end 
end