module Matches
  class IndexPresenter
    include Rails.application.routes.url_helpers

    def initialize(matches)
      @matches = matches
    end

    def attributes
      matches.map do |match, plays|
        {
          match: match(match),
          best_player: best_player(plays),
          most_used_weapon: most_used_weapon(plays)
        }
      end
    end

    private

    attr_accessor :matches

    def match(match)
      {
        id: match.match_id,
        show_path: match_path(match)
      }
    end

    def best_player(plays)
      plays.reject { |play| play.killer.nil? }
           .group_by(&:killer)
           .max_by { |_killer, p| p.length }
           .first
           .nickname
    end

    def most_used_weapon(plays)
      plays.reject { |play| play.weapon.nil? }
           .group_by(&:weapon)
           .max_by { |_weapon, p| p.length }
           .first
           .name
    end
  end
end
