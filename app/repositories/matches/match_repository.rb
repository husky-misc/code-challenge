module Matches
  class MatchRepository
    class << self
      def match_plays(id)
        Play.joins(:match)
            .where(matches: { id: id })
            .includes(:killer, :victim, :match, :weapon)
      end
    end
  end
end
