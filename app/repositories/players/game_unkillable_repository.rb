module Players
  class GameUnkillableRepository
    class << self
      def player_unkillable?(match, victim)
        return nil if match.nil? || victim.nil?

        Play.joins(:match, :victim)
            .where(match: match)
            .where(victim: victim)
            .size
            .zero?
      end
    end
  end
end

