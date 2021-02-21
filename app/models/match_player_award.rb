class MatchPlayerAward < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :award
end
