module Players
  class GameKillsRepository
    class << self
      def kills(match, killer)
        Play.joins(:match, :killer)
            .where(match: match)
            .where(killer: killer)
            .size
      end
    end
  end
end

