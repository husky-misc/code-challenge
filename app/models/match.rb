class Match < ApplicationRecord
    scope :by_created, -> { order(created_at: :asc) }
    scope :most_recently_created, -> { by_created.last }

    def max_players_per_match

    end

    def play(p1, p2, gun)             
        player1 = Player.find_or_create_by!(name: p1)
        player2 = Player.find_or_create_by!(name: p2)
        add_players(player1,player2) 
        player1.kill(player2, gun)
    end

    def add_players(*players)
        players.each do |player|
            begin
                MatchPlayer.find_or_create_by!(
                    player: player,
                    match: self
                )
            rescue Exception => e
                puts e.message
            end
        end
    end

end