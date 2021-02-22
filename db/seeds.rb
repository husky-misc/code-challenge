20.times do 
    Player.create!(
        name: Faker::Lorem.unique.word
    )
end

4.times do
    Team.create!(
        name: Faker::Games::Fallout.unique.faction
    )

    Award.create!(
        name: Faker::Device.unique.model_name
    )
end

Match.create!()

Player.all.each do |player|
    MatchPlayer.create!(
        match_id: 1,
        player: player
       
    )
end

15.times do 
    MatchPlayerAward.create!(
        match_id: 1,
        player_id: rand(1..20),
        award_id: rand(1..4) 
    )
end

15.times do
    Gun.create!(
        name: Faker::Dessert.unique.variety
    )
end

40.times do 
    KillLog.create!(
        match_id: 1,
        killer_id: rand(1..20),
        killed_id: rand(1..20),
        gun_id: rand(1..15)
    )
end


