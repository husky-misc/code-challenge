class Match::Creator < ApplicationService
  PLAYERS_LIMIT = 20

  class PlayersLimitExceededError < StandardError; end

  attr_reader :match

  def initialize(match)
    @match = match
  end

  def call
    validate_match
    match.save!
  end

  private

    def validate_match
      players_qty = players.size
      raise PlayersLimitExceededError, message(players_qty) if players_qty > PLAYERS_LIMIT
    end
  
    def players
      (match.kills.map(&:killer) | match.kills.map(&:killed)).compact
    end

    def message(players_qty)
      "Excedded limit of #{PLAYERS_LIMIT} players per match: #{players_qty} players."
    end  
end
