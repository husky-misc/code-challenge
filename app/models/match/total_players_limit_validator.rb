class Match::TotalPlayersLimitValidator < ActiveModel::Validator
  def validate(match)
    players_qty = match.players.size
    match.errors.add(:base, message(players_qty)) if players_qty > Match::PLAYERS_LIMIT
  end

  def message(players_qty)
    "Excedded limit of #{Match::PLAYERS_LIMIT} players per match: #{players_qty} players."
  end
end
