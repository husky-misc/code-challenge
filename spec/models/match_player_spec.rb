require 'rails_helper'

RSpec.describe MatchPlayer, :type => :model do
    
    let(:player) { FactoryBot.create(:player) }
    let(:match) { Match.create() }


    it 'Should have player' do
        match_player = MatchPlayer.create(
            player: player,
            match: match
        )        

        expect(match_player.player).to eq(player)
    end

    it 'Should bellongs to a match' do
        match_player = MatchPlayer.create(
            player: player,
            match: match
        )

        expect(match_player.match).to eq(match)
    end
    
    it 'Should have max of 20 players' do
        players = FactoryBot.create_list(:player,21)
        players.each do |player_one|
            MatchPlayer.create(
                player: player_one,
                match: match
            )
        end
        expect(MatchPlayer.count).to eq(20)
    end
    
end