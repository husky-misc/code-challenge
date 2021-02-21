class KillLog < ApplicationRecord
  belongs_to :match
  belongs_to :gun
  
  belongs_to :killer, foreign_key: :killer_id, class_name: "Player"
  belongs_to :killed, foreign_key: :killed_id, class_name: "Player"
end
