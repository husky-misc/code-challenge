class Match < ApplicationRecord
  has_one_attached :file
  has_many :plays
  validates :match_id, :file, :start, presence: true
  validates :match_id, uniqueness: true

  before_save :players_limit

  def players_limit
    unless new_record?
      if plays.present?
        plays.select(:killer_id, :victim_id)

        killer_ids = plays.map(&:killer_id)
        victim_ids = plays.map(&:victim_id)

        player_ids = killer_ids.concat(victim_ids).compact.uniq

        raise(StandardError, 'The maximun amount of players was reached') if player_ids.size > 19
      end
    end
  end
end
