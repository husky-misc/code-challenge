class MatchPlayer < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :team, optional: true

  validate :validate_max_number_of_players
  
  def self.ranking(id = nil)
    if(id)
      self.where(match_id: id)
    else
      self.all.distinct.pluck(:player_id)
    end
  end

  def validate_max_number_of_players
    errors.add("Reached max players") if MatchPlayer.where(match_id: self.match_id).count == 20
  end

  
end
