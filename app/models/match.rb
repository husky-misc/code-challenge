class Match < ApplicationRecord
  PLAYERS_LIMIT = 20

  has_many :kills

  validates_with TotalPlayersLimitValidator

  def rank
    RankQuery.new(self).call
  end

  def players
    (kills.map(&:killer) | kills.map(&:killed)).compact
  end
end
