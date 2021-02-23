class Player < ApplicationRecord
    validates :name, presence: true , uniqueness: true

    has_many :matches, class_name: "MatchPlayer"
    has_many :kill_logs, foreign_key: :killer_id
    has_many :match_player_awards

    def kill(player, gun)
        gun = Gun.find_or_create_by!(name: gun)
        KillLog.create!(
            match: Match.most_recently_created,
            killer: self,
            killed: player,
            gun: gun
        )
    end

    def get_kills(match)
        KillLog.where(match: match, killer: self).count
    end

    def get_deaths(match)
        KillLog.where(match: match, killed: self).count
    end

    def get_all_deaths
        KillLog.where(killed: self).count
    end

    def get_favorite_gun(match)
        self.kill_logs.where(match: match).group(:gun).count.
        map{|gun| [ gun[0].name, gun[1] ]}.
        sort_by(&:last).reverse[0][0]
    end

    def get_global_favorite_gun()
        self.kill_logs.group(:gun).count.
        map{|gun| [ gun[0].name, gun[1] ]}.
        sort_by(&:last).reverse[0][0]
    end
end
