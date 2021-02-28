module Players
  class GameMostUsedWeaponRepository
    class << self
      def most_used_weapon_from_winner(match, winner)
        Play.joins(:match, :killer)
            .where(match: match)
            .where(killer: winner)
            .where.not(weapon: nil)
            .group_by(&:weapon)
            .max_by { |_weapon, plays| plays.length }
            &.first
      end
    end
  end
end

