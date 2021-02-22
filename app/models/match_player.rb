class MatchPlayer < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :team, optional: true

  validate :validate_max_number_of_players

  def validate_max_number_of_players
    errors.add("Reached max players") if MatchPlayer.count == 20
  end
end
