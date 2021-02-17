class Match < ApplicationRecord
  has_many :scores
  has_many :players, through: :scores
  has_many :frags
  has_many :deaths

  validates :match_id, :start_date, presence: true
  validates :match_id, uniqueness: true

  def ranking
    players.uniq.map do |player|
      {
        name: player.name,
        frags: player.frags.where(match_id: id).size,
        deaths: player.deaths.where(match_id: id).size
      }
    end.sort_by { |data| data[:frags] }.reverse
  end
end
