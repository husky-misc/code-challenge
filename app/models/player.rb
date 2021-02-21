class Player < ApplicationRecord
    has_many :matches, class_name: "MatchPlayer"
    has_many :kill_logs, foreign_key: :killer_id
    has_many :match_player_awards
end
