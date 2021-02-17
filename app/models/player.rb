class Player < ApplicationRecord
  validates :name, presence: true

  has_many :frags
  has_many :deaths

  def deaths_per_match(id)
    deaths.where(match_id: id)
  end

  def frags_per_match(id)
    frags.where(match_id: id)
  end

  def favorite_gun(match_id)
    frags
      .joins(:gun)
      .where(match_id: match_id)
      .select("scores.*, guns.name, count(gun_id) guns")
      .group(:gun_id)
      .order("guns DESC").first
  end

  def self.global_ranking
    Player.all.map do |player|
      {
        name: player.name,
        frags: player.frags.size,
        deaths: player.deaths.size
      }
    end.sort_by { |data| data[:frags] }.reverse
  end

end
