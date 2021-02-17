class Score < ApplicationRecord
  belongs_to :player
  belongs_to :match
  belongs_to :gun
end
