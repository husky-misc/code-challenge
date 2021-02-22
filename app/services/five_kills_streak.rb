class FiveKillsStreak
  attr_reader :player, :match_id

  def initialize(player, match_id)
    @player = player
    @match_id = match_id
  end

  def award
    frags.map do |frag|
      frags.where(date: frag.date..frag.date + 1.minutes).size >= 5
    end.any?(true)
  end

  def frags
    player.frags.where(match_id: match_id)
  end
end