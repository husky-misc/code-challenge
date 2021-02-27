module Players
  class GameWinnerRepository
    class << self
      def winner(match)
        Play.joins(:match)
            .where(match: match)
            .group_by(&:killer)
            .max_by { |_killer, plays| plays.length }
            &.first
      end
    end
  end
end
