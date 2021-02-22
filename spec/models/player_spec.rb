require 'rails_helper'

RSpec.describe Player, :type => :model do
    context('When valid') do
        it 'Should bevalid' do
            player = FactoryBot.build(:player, name: Faker::Games::Fallout.unique.character)
            expect(player).to be_valid
        end
    end
    context('Shoub be invalid') do 
        it 'without a name' do
            player = FactoryBot.build(:player, name: "")
            expect(player).to_not be_valid
        end
        it 'without a unique name' do
            player_one = Player.create(name: "player")
            player_two = FactoryBot.build(:player, name: "player")
            expect(player_two).to_not be_valid
        end
    end
end