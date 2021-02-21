class KillLog < ApplicationRecord
  belongs_to :match
  belongs_to :gun
end
