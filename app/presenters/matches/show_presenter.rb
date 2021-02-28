module Matches
  class ShowPresenter
    include Rails.application.routes.url_helpers
    include ActiveModel::Validations

    validates :plays, presence: true

    def initialize(plays)
      @plays = plays
    end

    def attributes
      raise_validation_error if invalid?

      {
        match_id: match.match_id,
        players: players_score
      }
    end

    private

    attr_reader :plays

    def players_score
      match_players.map { |player| player_data(player) }
                   .sort_by { |player| -player[:kills] }
    end

    def player_data(player)
      {
        nickname: player.nickname,
        kills: player_kills(player),
        deaths: player_deaths(player),
        awards: awards(player)
      }
    end

    def match
      @match = plays.first.match
    end

    def match_players
      @match_players ||= plays.map(&:killer)
                              .concat(plays.map(&:victim))
                              .uniq
                              .compact
    end

    def awards(player)
      gifts = []
      gifts << 'Imorrível' if player_unkillable?(player)
      gifts << winner_weapon if winner?(player)
      gifts
    end

    def winner?(player)
      winner_weapon if player == winner
    end

    def winner_weapon
      weapon = Players::GameMostUsedWeaponRepository.most_used_weapon_from_winner(match, winner)
      "Rei da #{weapon.name}"
    end

    def winner
      @winner = Players::GameWinnerRepository.winner(match)
    end

    def player_unkillable?(player)
      Players::GameUnkillableRepository.player_unkillable?(match, player)
    end

    def player_kills(player)
      Players::GameKillsRepository.kills(match, player)
    end

    def player_deaths(player)
      Players::GameDeathsRepository.deaths(match, player)
    end
  end
end
