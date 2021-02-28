module Matches
  class BestPlayersRepository
    class << self
      def players
        Play.where.not(killer_id: nil)
            .includes(:killer)
            .group_by { |play| play.killer }
            .sort_by { |_player, plays| -plays.length }
            .first(10)
            .map { |player, _plays| player }
      end
    end
  end
end
