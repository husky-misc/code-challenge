class Play < ApplicationRecord
  belongs_to :match
  belongs_to :killer, class_name: 'Player', foreign_key: 'killer_id'
  belongs_to :victim, class_name: 'Player', foreign_key: 'victim_id'
  belongs_to :weapon

  validates :match, :gametime, presence: true
end
