module DashboardHelper
    def parse_log(import_log)
        file = File.open(import_log)
        data = file.read
        matches = data.split("ended")
        matches.each do |match|            
            data = match.split("\n").delete_if(&:empty?)           
            id = data.empty? ?  next : (data[0].split(" ")[5])
            new_match = Match.new(id:id)
            data.shift
            data.pop
            begin            
                if Match.create(id:id)
                    proccess_log_lines(data)
                end
            rescue Exception => e
                puts e.message
            end
        end
        redirect_to :action => "show"
    end

    def proccess_log_lines(data)
        data.each do |log_info|
            log_info = log_info.split(" ")
            unless log_info[3].eql?("New") || log_info[3].eql?("Match")
                player_log(log_info[3] , log_info[5], log_info[7])
            end       
        end     
    end

    def player_log(player1, player2, gun)
        if  player1 != '<WORLD>'
            match = Match.most_recently_created
            match.play(player1, player2, gun)
        end
    end

    def get_ranking
        ranking = {}
        Match.all.each do |match|
                ranking[match.id] = []
            MatchPlayer.ranking(match.id).each do |player|
                player = player.player
                kill_count = player.get_kills(match)
                ranking[match.id] << {
                    player: player.name,
                    kills:  kill_count,
                    deaths: player.get_deaths(match),
                    fav_gun: kill_count > 0 ? player.get_favorite_gun(match) : ""
                }
            end
        end
        ranking
    end

    def get_global_ranking
        ranking = []
        Player.all.each do |player|
            puts player
            kill_count = player.kill_logs.count
            ranking << {
                player: player.name,
                kills:  kill_count,
                deaths: player.get_all_deaths,
                fav_gun: kill_count > 0 ? player.get_global_favorite_gun : ""
            }
        end
        ranking
    end
end
