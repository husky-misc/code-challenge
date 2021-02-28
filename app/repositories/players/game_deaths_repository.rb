module Players
  class GameDeathsRepository
    class << self
      def deaths(match, victim)
        Play.joins(:match, :victim)
            .where(match: match)
            .where(victim: victim)
            .size
      end
    end
  end
end

