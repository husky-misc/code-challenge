module Matches
  class ResumeRepository
    class << self
      def matches
        Play.includes(:killer, :victim, :match, :weapon).group_by(&:match)
      end
    end
  end
end
